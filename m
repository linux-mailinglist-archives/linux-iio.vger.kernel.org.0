Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BF22D8673
	for <lists+linux-iio@lfdr.de>; Sat, 12 Dec 2020 13:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394321AbgLLMak (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Dec 2020 07:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388121AbgLLMab (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2020 07:30:31 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EC3C0613CF
        for <linux-iio@vger.kernel.org>; Sat, 12 Dec 2020 04:29:51 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id cm17so12253836edb.4
        for <linux-iio@vger.kernel.org>; Sat, 12 Dec 2020 04:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsok2RPJOoQxKjSmth57jC0EtSr7/fWnCkL1h2FgeXU=;
        b=lSl9laHR1y7EL1CdSoGRZUoGbRd/tDL1HGP954YjEm+uWb0Hp1iuoeCeFTtvJJoWct
         FpLdotPkLjhpkpVL8q6aPNqIdYt+F4CJNxClTSsmkrZfjv+cTZanfSiieQQSvWl14VIW
         A7weK5edrjaFh3oFefDiMCCG65ihl1oITAj9H0epTxFqtwQZ3/Gz1+kpwi/1m6JK/yVy
         88la4uLDyDzoui3fPPsLE1L42cuZbxafHGyVUYajLX4zTWRqpQo3sf1h9Wrw5tBXSXOH
         avrQr3I+pfhk+TBGYeNVPP2C/egxdjDfPxkHw+aKLOkkMhZ2xHboNsIQ65p8RewEUal4
         xVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsok2RPJOoQxKjSmth57jC0EtSr7/fWnCkL1h2FgeXU=;
        b=HgdXd0GdMaRac74+o86RlrxCEYwzRQkCw0OU5/IxF88I3RgMoHCFUDxfbjx+14OrbS
         PmX4utkiPbzFxDfwxvMM3UYomJvWv3ETQCj8n9/IfDklOnL/oVA47/5wM6jT69cLFCBh
         2dEda9R6OT87iP/kQsjSqNA0B75eGJkk2mz1/8N6wG2KA0X9IJkHd+T1YAmEjuVr/d6o
         icwLNNWyHW8L+mmZ3ccohHZWyX6H1G6ZBICT46WJxXBXRDpAxf+0gNzBvSlspfcRU7AM
         gS8XHnVJX0wYdykxKJ+leEmNWCeAIElGp5BXvIUhicuoXnHst8mDAh0cUQq5tIsNtxCS
         1T6w==
X-Gm-Message-State: AOAM53310hBY50vaoi0W4ic3LjHLeTUqd5PZ/kJ0M+1ncWVgKHCDqmxi
        EZMbISBh0iyn/yMHToMS2BpP3yLhZafw4TO2XtXjfg==
X-Google-Smtp-Source: ABdhPJw5TE5K21FCm6i79Bdn/TYcFZ6knxEy8qnKsDlJ393w1NWhaCXaTzzBna6CvUW+sSx9l9qnSY1wTBdNX0Sq4jk=
X-Received: by 2002:aa7:cccf:: with SMTP id y15mr16622230edt.112.1607776189874;
 Sat, 12 Dec 2020 04:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20201211111254.9376-1-sis@melexis.com>
In-Reply-To: <20201211111254.9376-1-sis@melexis.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Sat, 12 Dec 2020 13:29:13 +0100
Message-ID: <CAKv63uu7-eQAn7ajXoV0DhBEkb+KaHQqnW01GA52s+1VZ_023A@mail.gmail.com>
Subject: Re: [PATCH] drivers: iio: temperature: Add delay after the addressed
 reset command in mlx90632.c
To:     Slaveyko Slaveykov <sis@melexis.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reviewed-by: Crt Mori <cmo@melexis.com>

We did not detect this issue on Linux chips, but there is a slight
possibility that it might occur nevertheless.  So I am proposing this
to add to_fixes as well (maybe even for the upcoming 5.10?)

Best regards,
Crt

On Fri, 11 Dec 2020 at 12:14, Slaveyko Slaveykov <sis@melexis.com> wrote:
>
> After an I2C reset command, the mlx90632 needs some time before
> responding to other I2C commands. Without that delay, there is a chance
> that the I2C command(s) after the reset will not be accepted
>
> Signed-off-by: Slaveyko Slaveykov <sis@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 503fe54a0bb9..ee50f61e496a 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -247,6 +247,7 @@ static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
>         ret = regmap_write(regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
>         if (ret < 0)
>                 return ret;
> +       usleep(150, 200);
>
>         ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
>                                  (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
> --
> 2.16.2.windows.1
>
