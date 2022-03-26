Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2640D4E7C4F
	for <lists+linux-iio@lfdr.de>; Sat, 26 Mar 2022 01:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiCZAGe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Mar 2022 20:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiCZAGJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 20:06:09 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C91C60CB
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 17:04:33 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id o64so9882468oib.7
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 17:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=jwFW8Oz6fBG29J9Ewie6Ji+0UnbjUoBUP9kpqKZDR4I=;
        b=gjx4ZwPJxPyxvuOxSi4BYLE3ybI8ea+9RghPRvTSYD1iysuG56ZeZFpTWw9OnYbnZ0
         pLQwkqlV5pVgDr3s/pnwz2CJw44uZd30AdfB3fj9ihWSNoPM69Iacz5lwHn4Q6sdEcA3
         IQFubKYD0S9J1GeEKpmZYSBRhpXZZB6CRqpKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=jwFW8Oz6fBG29J9Ewie6Ji+0UnbjUoBUP9kpqKZDR4I=;
        b=L0Oq9xhKkaAd2oY8mMkPPkNU36ZrGAG6y9M3JGyG1g+xCoWUHhTEwf1YhdUwAMirDj
         01cAtJIjHxJL5AT3d7OE8yQOQk7h2R+24kVUGb5lijt+kllYNRQtGMA10O210tG++Oev
         qMsEa9QQzL5thsTNVg91tnR493I0s7dLsEdsLdh5ZO2qii1lDn/wLXayokWxD8Z3gWmA
         EzlI2Q3rrd0EAAotmA6SxZ1dln9SN7SAsgPjqjpkGz7+mnJyGc/2VabxN9G7DDt+TBs1
         wtGSkUHzz89SqrcMo4kCjQ+gN/MwR1fEN85mKx8obxurtbqE2FG9OUlGiZ6bcy1tyXdM
         dGZA==
X-Gm-Message-State: AOAM532PsSjo8N1ZMV11neHmG2DdiX6OIdntqJIwsLk+/np3XnKkpUxC
        ebxCdjGW/XOguv3nj6vsxCu79wC+lNdHGYVTcgOQBA==
X-Google-Smtp-Source: ABdhPJzCJJ13Ov8+p7erLu4bZlSmA1H/Yks/X1PPcYHmDu/rJIPL/H+awEx/3wT2GG1T/DjF7f5R0bvGdP5j4TWG2GI=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr6909143oif.63.1648253073349; Fri, 25
 Mar 2022 17:04:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Mar 2022 19:04:32 -0500
MIME-Version: 1.0
In-Reply-To: <20220325220827.3719273-7-gwendal@chromium.org>
References: <20220325220827.3719273-1-gwendal@chromium.org> <20220325220827.3719273-7-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Mar 2022 19:04:32 -0500
Message-ID: <CAE-0n50a+d+MV9MQ4phppBhkvdgGU4cqC-9ZN9GjbhbRi+pUnQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] iio: sx9324: Add Setting for internal compensation resistor
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-03-25 15:08:25)
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 3f229dffd5380..38dfdc6dc86ad 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -875,6 +881,22 @@ sx9324_get_default_reg(struct device *dev, int idx,
>                                SX9324_REG_AFE_PH0_PIN_MASK(pin);
>                 reg_def->def = raw;
>                 break;
> +       case SX9324_REG_AFE_CTRL0:
> +               ret = device_property_read_string(dev,
> +                               "semtech,int-comp-resistor", &res);
> +               if (ret)
> +                       break;
> +               reg_def->def &= ~SX9324_REG_AFE_CTRL0_RINT_MASK;
> +               if (!strcmp(res, "lowest"))
> +                       reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_LOWEST;
> +               else if (!strcmp(res, "low"))
> +                       reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_LOW;
> +               else if (!strcmp(res, "high"))

Should the order of arguments be swapped? I'm wondering if I can have
'hig' in the DT property and then it will match 'high' here? I suppose
the schema validator will find that and complain first.

> +                       reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_HIGH;
> +               else if (!strcmp(res, "highest"))
> +                       reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_HIGHEST;
> +
> +               break;
