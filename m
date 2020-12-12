Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931C42D8957
	for <lists+linux-iio@lfdr.de>; Sat, 12 Dec 2020 19:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgLLSph (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Dec 2020 13:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgLLSph (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2020 13:45:37 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E05C0613CF
        for <linux-iio@vger.kernel.org>; Sat, 12 Dec 2020 10:44:57 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x18so334314pln.6
        for <linux-iio@vger.kernel.org>; Sat, 12 Dec 2020 10:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=un0HUehDYwt/xWhUMOwAhSospotLNqiYskOZKW/zD7o=;
        b=Tkfg/+sojoFLDtd+788wc403ASf9L/bVJxrIG2+j1FwjvfAtR4wXanif03+ycNCowm
         8H/V9hiHIvBXLMHAXyN4p+9Zmkdks3XMySBapxFNZa83F4QOQzBrAIpKarHZBioEZ/AV
         VPOFj5PBL7vvAKVOQC8PoQRD00sa4m4TihFjhB3DKaYt1Tmgvfau+bG4xzXRfRuIK0kl
         jKGm27mXT/tYHOHtMjD2OqbGivRJM+u4zExEZAtR0NnLJlD44z8ochp1WkMA/GcKFphg
         15WuMiU33lU1lNsz254XzmTceiMmjalqjTO5oJL3k+OsPd0dbDBlelrY1AhXLyk2NNqI
         P5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=un0HUehDYwt/xWhUMOwAhSospotLNqiYskOZKW/zD7o=;
        b=DFJAMXo/vWySuN5zuEt8p6vE5AGy9TuAtmyQTMgq1XT6UcFM+/UKJ+jq0vvfkiKYLd
         zP7Cp1/ioVvIxBvnT8UPQFRafMIO7hGMKh2asgSiZ8imzbj2+U0l4LMa5Y6XLc50Lbt+
         aziV2sh3s2QV1IU+Slbtk9N4RU+EQIRWXNygk4pE8Bgnxyy10IAvzWs9/YpgG9pg1TMu
         5y4LexwdCNP/JzcQYe0+KOS4vaaQvq0yQJOQhxgtvo440pvmJkAB+rSdxWANw5uE4EsZ
         yT/LvpYP/Ba1pAzjw6R0PwfKbsr6iNkJCOrF9gdZtfslKXCbU+cfWfnPDeZFy98/NuwU
         AYrw==
X-Gm-Message-State: AOAM532d5n6lkFBNVYDquSakuQNjQmQ6pm16TYZrSxFbvVK/g9dR+z4R
        qFFLArp0b7cx7MmhgjLAd0kdbk8RcoY5ny3WV+o=
X-Google-Smtp-Source: ABdhPJyLQ2A/m4YDhjr2xKJ0K8FQHk6H/NIOF/6b+Cq9gL2BIhck/J767HPUru2ODyf1HP0+/62L51AggO5rnncwX+0=
X-Received: by 2002:a17:902:e98c:b029:da:cb88:f11d with SMTP id
 f12-20020a170902e98cb02900dacb88f11dmr15931020plb.17.1607798696720; Sat, 12
 Dec 2020 10:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20201211111254.9376-1-sis@melexis.com>
In-Reply-To: <20201211111254.9376-1-sis@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 12 Dec 2020 20:44:40 +0200
Message-ID: <CAHp75VfTzLNAQUvh5gfedHiXyzfwOxkDJJtd9B=_SusR+ivLNA@mail.gmail.com>
Subject: Re: [PATCH] drivers: iio: temperature: Add delay after the addressed
 reset command in mlx90632.c
To:     Slaveyko Slaveykov <sis@melexis.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Crt Mori <cmo@melexis.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 11, 2020 at 3:46 PM Slaveyko Slaveykov <sis@melexis.com> wrote:
>
> After an I2C reset command, the mlx90632 needs some time before
> responding to other I2C commands. Without that delay, there is a chance
> that the I2C command(s) after the reset will not be accepted

...

It's good to put some comments here in the code.

> +       usleep(150, 200);


-- 
With Best Regards,
Andy Shevchenko
