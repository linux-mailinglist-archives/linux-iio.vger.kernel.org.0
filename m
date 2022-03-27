Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA1B4E898E
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiC0TK7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiC0TK6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 15:10:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D09722B0E;
        Sun, 27 Mar 2022 12:09:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bq8so10604456ejb.10;
        Sun, 27 Mar 2022 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHTo90e+pgzSDpNnHp4JH/jEnvng/GvATMflbVHHS0Y=;
        b=Orh7nTeGm1vtfIcyTxf2ill2xZvAyunOZm56IzCf93aaLx9xC0Sl/tFNuoFogV4ufq
         IL/iuRMfGN20r0w9ys5S3WE7pcms8fQwDvbZVqRADEFh/IoWMYR+jDjTABjNw0Br6k2k
         oLe0UH0AiQOe2NCg/eamCFBuch7h44jTmM0QRY4Mrm5075wzypxoemQ4WfQLa+cP5Ar0
         iiir80nLzmNiU5LBzoqWxHK0jLJ3ohREP6tKLuqGZRoAw/NGSqb6+rQkhgVUt4uwBCMc
         DT7pn1GsXr+4gT5MiC8jjQVEFXQsA9pyhzBVfSyH8yThHp3rD0w4bW/QJoniDKWnQ3JG
         HC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHTo90e+pgzSDpNnHp4JH/jEnvng/GvATMflbVHHS0Y=;
        b=fMJFakdGHlpq78rIJLPXg1bTCatzhG7HoF/T36InK3QvavTmQ/kztoMTzzoHnkGXzN
         pSOwlbQO4czOfPHRXjVj/+lgpRtnr2H7RW3sHO3QVny51IBtwE3akRC3hy89yF3E15mR
         lP5TIMtNkX9SePGYYdV3UtR6Rb1S3QzJvPngX11Xm3tgcc9O31hq5N8LnjOu04FlRa4I
         q8HJNAxz6O2Psnv/diDiCC9MytQN/4TQr6IwErTBBHQMtaZ6kLfQwOnZn+LzTQI1s4On
         3gh/t2WkJd1sZzsUzS/d1bRXTXsun8k68p9GpuiyU2kxngaC1Qc6Gupdb7lz0PaiCoWF
         eGJg==
X-Gm-Message-State: AOAM532GnTG90aHUwbTy8m0qB0Eswv+IkolWVOZC/uj+RzqMEX+x7Rq0
        24Iu1rR4xZua92t0j01XKOWZYLdy1wSSUSQFBmRRoiNgulnxag==
X-Google-Smtp-Source: ABdhPJxqtBf1ohvPQEvmcZoDnAzrKtn59oxHBEQufBwkmCf+EmIIHx91LW0Q6A8phW+D4SNkCJrAm8jaZ1O+tzb9l0w=
X-Received: by 2002:a17:906:4cc7:b0:6d0:7efb:49f with SMTP id
 q7-20020a1709064cc700b006d07efb049fmr23354395ejt.639.1648408155047; Sun, 27
 Mar 2022 12:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220325220827.3719273-1-gwendal@chromium.org> <20220325220827.3719273-7-gwendal@chromium.org>
In-Reply-To: <20220325220827.3719273-7-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Mar 2022 22:08:39 +0300
Message-ID: <CAHp75VdJkUoZPqQC347DxfrsQEmznhZtF8C-Aa_Rvt0hXJpppQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] iio: sx9324: Add Setting for internal compensation resistor
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 26, 2022 at 12:34 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Based on device tree setting, set the internal compensation resistor.

...

> +               if (!strcmp(res, "lowest"))
> +                       reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_LOWEST;
> +               else if (!strcmp(res, "low"))
> +                       reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_LOW;
> +               else if (!strcmp(res, "high"))
> +                       reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_HIGH;
> +               else if (!strcmp(res, "highest"))
> +                       reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_HIGHEST;

As far as I can see the values, you can simply put the string literals
into the array:

static const char * const sx9324_rints = { "lowest", "low", "high", "highest" };

Then

  ret = match_string(sx9324_rints, ARRAY_SIZE(sx9324_rints), res);
  if (ret < 0)
    return ret;
  reg_def->def |= ret << SX9324_REG_AFE_CTRL0_RINT_SHIFT;

-- 
With Best Regards,
Andy Shevchenko
