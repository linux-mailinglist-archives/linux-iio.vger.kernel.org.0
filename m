Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3D4E87E5
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiC0NhM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiC0NhL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 09:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A236B2FFCC;
        Sun, 27 Mar 2022 06:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 368D361011;
        Sun, 27 Mar 2022 13:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E023DC340EC;
        Sun, 27 Mar 2022 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648388132;
        bh=6w4SvLbypNtY/LDYTBN92SOalX1diMeFOQeOpzZbuOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fe6JPPtej5E8mtrNTB/9SLcF8r0PSoJXSm0zOoUWunTqw+jXtGFF1ARRa54pILqyN
         doM3H3mDzrnZRcIxhxFmBjqDBJ6Fms6GvHMXoOtaFB05Bk5LoakbCRQiAqlCpV2xgw
         bucce4/37+JBuvSPuO7E7OGLvRWt04noMKhi/BcGZ5ZXe7mo9c3+Z00sGqmzo62Zns
         joQf0exP3a3dn7kvz80qKoIszpuOWHeqsEYhOzUBNT+a60852CydPQvrD6U6PO5Rml
         6ev3VaaARwtWRYGUuF6qHjV0FT3PqzraAfnjyr10I1xLyqjg1Yn8VL64Fjw8CU2X8D
         p/bhqJYTuZlFA==
Date:   Sun, 27 Mar 2022 14:43:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/8] iio: sx9324: Add Setting for internal
 compensation resistor
Message-ID: <20220327144305.0aefad4b@jic23-huawei>
In-Reply-To: <CAE-0n50a+d+MV9MQ4phppBhkvdgGU4cqC-9ZN9GjbhbRi+pUnQ@mail.gmail.com>
References: <20220325220827.3719273-1-gwendal@chromium.org>
        <20220325220827.3719273-7-gwendal@chromium.org>
        <CAE-0n50a+d+MV9MQ4phppBhkvdgGU4cqC-9ZN9GjbhbRi+pUnQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Mar 2022 19:04:32 -0500
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Gwendal Grignou (2022-03-25 15:08:25)
> > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> > index 3f229dffd5380..38dfdc6dc86ad 100644
> > --- a/drivers/iio/proximity/sx9324.c
> > +++ b/drivers/iio/proximity/sx9324.c
> > @@ -875,6 +881,22 @@ sx9324_get_default_reg(struct device *dev, int idx,
> >                                SX9324_REG_AFE_PH0_PIN_MASK(pin);
> >                 reg_def->def = raw;
> >                 break;
> > +       case SX9324_REG_AFE_CTRL0:
> > +               ret = device_property_read_string(dev,
> > +                               "semtech,int-comp-resistor", &res);
> > +               if (ret)
> > +                       break;
> > +               reg_def->def &= ~SX9324_REG_AFE_CTRL0_RINT_MASK;
> > +               if (!strcmp(res, "lowest"))
> > +                       reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_LOWEST;
> > +               else if (!strcmp(res, "low"))
> > +                       reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_LOW;
> > +               else if (!strcmp(res, "high"))  
> 
> Should the order of arguments be swapped? I'm wondering if I can have
> 'hig' in the DT property and then it will match 'high' here? I suppose
> the schema validator will find that and complain first.

Wouldn't that result in a failed match between the null terminator of the first
string and the 'h'? Hence I don't think it matters but maybe I'm missing something..

> 
> > +                       reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_HIGH;
> > +               else if (!strcmp(res, "highest"))
> > +                       reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_HIGHEST;
> > +
> > +               break;  

