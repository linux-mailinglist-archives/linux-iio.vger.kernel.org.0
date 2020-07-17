Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1902322448D
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 21:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgGQTsn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 15:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgGQTsn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 15:48:43 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB5C0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 12:48:43 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v8so11641219iox.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7NpXK7JzSgbCI2SuDg2Kli8CN6q+obgk+/Z7+f8u0g=;
        b=TmH4Q9LgejjEiu1Qaerlx7MagvT4cQZhkhKFD8S9oozZ4oumKAnSPAZdi0n02nFbwh
         xhdImQYdacWvA+zIrwUxLaJk0+p3VQphqd6nihnTS8LGLjCFfAk2cOxMWEpYfxRFy2Hg
         2Frx+TLq5CVW0xNJJvTtyZtDq5knxKSY9AinoPbfgAcHtfUR2m1uz41/fovMfy36dNyi
         moah1R8A1ofRQ4NOh6Z6qHpAoIzmQCmxaquPu8t1Rok3c6dPSn234Lts6XgJP+E8pD4n
         9wQLx2CKAItaKafogOSBDENoXtEtFckkXMOwAqN32x3LD3PYvdWt1z+yYIwxOuQzq1dl
         07Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7NpXK7JzSgbCI2SuDg2Kli8CN6q+obgk+/Z7+f8u0g=;
        b=qHWJVCRYn58DGfgt4bStk1kv2iD1nJHfk1xzunul9IZuXmZvRSbcztHIjXef0rzM+x
         NJJrEC03DdHFfCiXfOE9DsEgjmMBXAcaBZPE6Co32HGt+XUWp8mUU8OoNYbOGXRUHBR2
         WnG5s4RIy1A/AYgJSu9U2MQDfheF+2UYPnVwMK+VxoQSdaxewnaL3EAqaIpQozD4aBEV
         ms090+OeUMjHmQtAjbfHeGdl+A+nTzkvhcgnV6T0dECVoVsjlL2I/k460bqDemHcA5DR
         QAIuXQhqVrY8u1Er07sWdfCTWnDFuzk3OhZ2xK1mE2UuvO23T7mQmS4CPV3Rril4A/ed
         pvrA==
X-Gm-Message-State: AOAM533cwVMHi52LELkOIAr0dgotpOqNJzkfS+VEhLZm0HsNm858aJji
        JZGD0Km7c5GemK01pAwdWEztTJIuHWlBEFCrLkGJmw==
X-Google-Smtp-Source: ABdhPJyY9OnzdwqNgOEY8poFbPfdtNAb7beS3Be89cJ/AsAbTErEXIkHXehj7O5ureYZn+24mXJO8R7RaiaqWG4nlFQ=
X-Received: by 2002:a05:6602:21c3:: with SMTP id c3mr10602170ioc.93.1595015322241;
 Fri, 17 Jul 2020 12:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200717165538.3275050-1-lee.jones@linaro.org> <20200717165538.3275050-10-lee.jones@linaro.org>
In-Reply-To: <20200717165538.3275050-10-lee.jones@linaro.org>
From:   Crt Mori <cmo@melexis.com>
Date:   Fri, 17 Jul 2020 21:48:06 +0200
Message-ID: <CAKv63uvMb1R2OyBwFuCTU+E5YQfHwBB+bqRP+jXO9yn4e2Wu6w@mail.gmail.com>
Subject: Re: [PATCH 09/30] iio: temperature: mlx90632: Function parameter
 descriptions must match exactly
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Johnathan Iain Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-arm-kernel@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-by: Crt Mori <cmo@melexis.com>

On Fri, 17 Jul 2020 at 18:56, Lee Jones <lee.jones@linaro.org> wrote:
>
> '*'s are not welcome in kerneldoc parameter names.
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/iio/temperature/mlx90632.c:175: warning: Function parameter or member 'data' not described in 'mlx90632_perform_measurement'
>
> Cc: Crt Mori <cmo@melexis.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/iio/temperature/mlx90632.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index eaca6ba068646..b9a8089be3f63 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -164,8 +164,8 @@ static s32 mlx90632_pwr_continuous(struct regmap *regmap)
>  }
>
>  /**
> - * mlx90632_perform_measurement - Trigger and retrieve current measurement cycle
> - * @*data: pointer to mlx90632_data object containing regmap information
> + * mlx90632_perform_measurement() - Trigger and retrieve current measurement cycle
> + * @data: pointer to mlx90632_data object containing regmap information
>   *
>   * Perform a measurement and return latest measurement cycle position reported
>   * by sensor. This is a blocking function for 500ms, as that is default sensor
> --
> 2.25.1
>
