Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA960B159
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 18:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiJXQUL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 12:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbiJXQTh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 12:19:37 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C732115436;
        Mon, 24 Oct 2022 08:05:47 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h24so5750412qta.7;
        Mon, 24 Oct 2022 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QuRSYRsBBAeZV4fcTjPOUogplLOaj6PiAdrhBn0xRFc=;
        b=TRC5DsPBnnroOzB2R+k7IqSDXUB8zUw5cJS8GSsv3Sv3JpjzME2PlcEZyD0HdKIfAl
         TT0WmdZdr4LnCHt6TzkYLrbkUevvOGMJWNt6sg9VF5lzlbC/YwVlm7oCf/RsC5xlAJaU
         ntdDGymdDlSSfXjVU/OfNSQ/pDaKsKm7pt+nTS88XMWgHD3MiZ8WsfYUC2n9EjJlu/FL
         mLQjpCSREQIMXan/3vtGwkQPVK59lZjXicFGppG48LN4wDW18ChdjMgKHn7b9X9p4lDM
         kMs71ar5oE4cnKJiVTshlaj3fzV5RLPmUWuooQzRFMtWNrntFp75N2GtsGniedKxVIB4
         yhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QuRSYRsBBAeZV4fcTjPOUogplLOaj6PiAdrhBn0xRFc=;
        b=Ylcfal068ICxDPwUQUmO89fMwXkEpfVJ1ss5kH37ziHb+/E6InAs/ouy6rZQ+bcFBV
         st/SOqXEaO4fFL4NY1m9umvXrkd2ItWqGo1SJMZLCsLhwPrmVm18QjyZyf5EtIfcy+gr
         oLibEmkTehjn2/s14UQ/q8tB60p/PO3KqirffxnACevvsGFMsAL9/wkp9znLj0HnwdEM
         1yOhqe8zbe5UF189keB1kURhOjpPFFldN96dN6pl/fiJM0rJBNcbK5uHcF1wxPpD5W/W
         Oi/cqaT2GwfTcaFeIe9AIkGM+Ffio3IVixxudE/7mh9Z8AcvdxD8IT5BVVZV2EGdvabn
         hfJw==
X-Gm-Message-State: ACrzQf35P2HI2cJbtJIZcoib53cQwDsSDSiVUJ7dvfGxzNYOmi7heX1J
        X8xXHJG3Um5mv2EiuJB19Ku9NwPy8TX0W+tBDmVeRDEYJUg=
X-Google-Smtp-Source: AMsMyM6/vj+OYU1fRsLNLVy+HcOFy1orUfoRd/mpNbcZyL3cQ3fg3lm2uBrQdR/K8mMJSxGHIWgDdf1nm1tdZD/DXvM=
X-Received: by 2002:ac8:5c83:0:b0:39c:e9b9:9efd with SMTP id
 r3-20020ac85c83000000b0039ce9b99efdmr27992397qta.481.1666619400481; Mon, 24
 Oct 2022 06:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221024132757.3345400-1-sravanhome@gmail.com> <20221024132757.3345400-7-sravanhome@gmail.com>
In-Reply-To: <20221024132757.3345400-7-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 24 Oct 2022 16:49:24 +0300
Message-ID: <CAHp75VcvZ9drkFfbpVJFz0UWQvOMgAu3+JmV4HvOG3dPKDoN5w@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] power: supply: fix failed to get iio channel by
 device name
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 24, 2022 at 4:28 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> The mfd cell devices name populated on sysfs entry is dynamically derived
> from an auto instance which introduced a regression. As a result
> mpc2629_charger driver failed to get adc channel because of iio consumer
> name mismatch with the sysfs.
>
> /sys/class/i2c-adapter/i2c-1/mp2629_adc.0.auto/
> /sys/class/i2c-adapter/i2c-1/mp2629_charger.1.auto/
>
> Fixes: 466a62d7642f(mfd: core: Make a best effort attempt to match devices)

Wrong Fixes tag format, moreover the fixes should be grouped at the
beginning of the series, so it will be visible and splittable based on
this property.

-- 
With Best Regards,
Andy Shevchenko
