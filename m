Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225755788DD
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 19:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiGRRwu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 13:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiGRRwm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 13:52:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27AD2E9DF
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 10:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6723BB81658
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 17:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A747C341C0;
        Mon, 18 Jul 2022 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658166759;
        bh=Vn94vaV/LgOdiiFESu93ZDKb4+UrZoXhtszF40xuESo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fWmhc7eKqL1Sm7KfZK6JMlXsSrmyg+zgUygOFk/S1R0lpb1qCEVkfN4DWyl1DylTo
         zPCohuZ0DQdFCpMQv1Ji46eAb/jWuyAFVf2ShPXjKhSkWR/ryhSfcEPt22fldjM0BH
         2gONMlU/XHUQqOFEwE2jBtmGA3NShH270L4AaiP2okoI+s+yI7fjRUrCRLbeXkOCg0
         4pQcOI5uzCmkmwF5IWhBTeHz+sl51xqGnkzSnsCFw+RA8kUwOCK0dSiYRkyVBZ7eZz
         NFqtPXqcrsPBC67ppeJCvRJfuWwey5aZsDboGyGIdUc5SaxU59gSdO/t8A4SoUTzl7
         VbZW1JSbCd7Ow==
Date:   Mon, 18 Jul 2022 19:02:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 11/17] iio: core: Introduce _zeropoint for
 differential channels
Message-ID: <20220718190235.6578113b@jic23-huawei>
In-Reply-To: <CAHp75VcSaW08brrFRhKQYVCLbNdQz=SG80OmYkPrv028wSuk6g@mail.gmail.com>
References: <20220626122938.582107-1-jic23@kernel.org>
        <20220626122938.582107-12-jic23@kernel.org>
        <CAHp75VcSaW08brrFRhKQYVCLbNdQz=SG80OmYkPrv028wSuk6g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Jun 2022 14:17:33 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 26, 2022 at 2:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Address an ABI gap for device where the offset of both lines in a
> > differential pair may be controlled so as to allow a wider range of
> > inputs, but without having any direct effect of the differential
> > measurement.
> >
> > _offset cannot be used as to remain in line with existing usage,
> > userspace would be expected to apply it as (_raw + _offset) * _scale
> > whereas _zeropoint is not. i.e. If we were computing the differential
> > in software it would be.
> > ((postive_raw + _zeropoint) - (negative_raw + zeropoint) + _offset) * _scale
> > = ((postive_raw - negative_raw) + _offset) * _scale
> > = (differential_raw + _offset) * _scale
> >
> > Similarly calibbias is expected to tweak the measurement seen, not
> > the adjust the two lines of the differential pair.
> >
> > Needed for in_capacitanceX-capacitanceY_zeropoint for the
> > AD7746 CDC driver.  
> 
> ...
> 
> > +What:          /sys/.../iio:deviceX/in_capacitanceY-capacitanceZ_zeropoint
> > +KernelVersion: 5.19  
> 
> 5.20?

:) Probably 5.21 as I'm not going to rush this in now, but good point none the less.

> 
> > +Contact:       linux-iio@vger.kernel.org
> > +Description:
> > +               For differential channels, this an offset that is applied
> > +               equally to both inputs. As the reading is of the difference
> > +               between the two inputs, this should not be applied to the _raw
> > +               reading by userspace (unlike _offset) and unlike calibbias
> > +               it does not affect the differential value measured because
> > +               the effect of _zeropoint cancels out across the two inputs
> > +               that make up the differential pair. It's purpose is to bring  
> 
> makes

No.  make is correct.
That's indeed an odd corner of English and honestly I'm not sure I could successfully
argue why it should be make :)

> 
> > +               the individual signals, before the differential is measured,
> > +               within the measurement range of the device. The naming is
> > +               chosen because if the separate inputs that make the
> > +               differential pair are drawn on a graph in their
> > +               _raw  units, this is the value that the zero point on the
> > +               measurement axis represents. It is expressed with the
> > +               same scaling as _raw.  
> 

