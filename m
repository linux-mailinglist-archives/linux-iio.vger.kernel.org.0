Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E77E4C77DE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Feb 2022 19:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbiB1SeW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Feb 2022 13:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbiB1SeQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Feb 2022 13:34:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75B253B44;
        Mon, 28 Feb 2022 10:19:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46BAB61382;
        Mon, 28 Feb 2022 18:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CEBC340E7;
        Mon, 28 Feb 2022 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646072361;
        bh=esk0tt6NfHBQGDU8W2A3w8Fz1t0f515RUeQTILKlsZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t6NJVxUGaUFMUEnTTgcDbU02n5dRhA9RqY8U9ExA9nKK9ID7gSkfoZSG2S4m9sWKy
         h3uYCWE6s25tS6rzOtGolcDwhV4lzXA4Tce6oQNpGoSGrk7YXnEVQcPR60YzB2oYk5
         9V3oCAIpSUD/XSuZ1oi4rjH4OD5jhSYF0yvqVffefMQ6sWp6QIgGKYzlIbIbUHRjvL
         Et+DbUL//M1r10BG+RON5+Q61g2jHrZ/L6v+Z75ROi/Eeo0AX86y/TNIGNT8jGnkK4
         U9640fMGSQXqcF75LSFElcaan4ARLOPdN55kU4/gZmydixLo0k+9Ad20YAsLc70Tpp
         XYAiO3eayDMDQ==
Date:   Mon, 28 Feb 2022 18:26:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Robert Hancock <robert.hancock@calian.com>,
        "anand.ashok.dumbre@xilinx.com" <anand.ashok.dumbre@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Xilinx AMS fixes
Message-ID: <20220228182626.12544642@jic23-huawei>
In-Reply-To: <56c261b2-2bf0-16d1-8fdb-a264709cba09@xilinx.com>
References: <20220127173450.3684318-1-robert.hancock@calian.com>
        <20220130124605.6268bfc5@jic23-huawei>
        <9aeda9dd153f470ae630cff79c374e66ffbeade8.camel@calian.com>
        <20220226164552.7fed4f1d@jic23-huawei>
        <56c261b2-2bf0-16d1-8fdb-a264709cba09@xilinx.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Feb 2022 07:40:59 +0100
Michal Simek <michal.simek@xilinx.com> wrote:

> On 2/26/22 17:45, Jonathan Cameron wrote:
> > On Wed, 9 Feb 2022 19:49:27 +0000
> > Robert Hancock <robert.hancock@calian.com> wrote:
> >   
> >> On Sun, 2022-01-30 at 12:46 +0000, Jonathan Cameron wrote:  
> >>> On Thu, 27 Jan 2022 11:34:46 -0600
> >>> Robert Hancock <robert.hancock@calian.com> wrote:
> >>>      
> >>>> Various fixes for the Xilinx AMS driver.
> >>>>
> >>>> Changes since v1:
> >>>> -drop addition to ZynqMP device tree, will be submitted elsewhere
> >>>> -add patch to fix DT binding to add missing clock entry  
> >>>
> >>> I'm fine with these but would like to leave them all on list a tiny
> >>> bit longer so we can hopefully get some review, particularly on patches
> >>> 1 and 4.
> >>>
> >>> Jonathan  
> >>
> >> Hi all,
> >>
> >> I don't think I've gotten any feedback. Is anyone able to review/test?
> >>  
> > Michal,
> > 
> > If you have a chance to take a quick look at this series that would
> > be great.  
> 
> That series looks good to me. Please apply and feel free to add my
> 
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
Applied to the fixes-togreg branch of iio.git.

I'm not certain I'll get a fixes pull request out in time to make this
cycle so these might get dragged across to my togreg branch and
added to a pull request for the merge window. Or, possibly Greg
will take them for the merge window even if I do a separate pull given
we are close to the end of the cycle.

Thanks,

Jonathan

> Thanks,
> Michal

