Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C942F7D801E
	for <lists+linux-iio@lfdr.de>; Thu, 26 Oct 2023 11:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjJZJ4t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Oct 2023 05:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjJZJ4t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Oct 2023 05:56:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A5219B;
        Thu, 26 Oct 2023 02:56:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50802148be9so765464e87.2;
        Thu, 26 Oct 2023 02:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698314201; x=1698919001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIHrwT1IPJSaVwo9toEDHyrvoQFfktSqXsqS3njZKmY=;
        b=QlPTn5Z9dFonCrT8DYbptGRXh7V00BD/frE3sBNwN66Y2Vfyn2smyIWXzGEOtoqwS+
         +QTFBob0khaeliZX1ZZxC9oNJPXTE6vcAlkmnteVjh8TT8cZS6J3PQnxOUaoR7s+bN65
         Y5QlOIYcvt7JmDj0WuCEBymnmE4up7wFyK9t+SnlUCqaLt80BbyVO/UQkIpX6JeunVFA
         sUEC8ThZwxVRRgizAX484HAx3HH1HbjmIa9L1iE5zrbWB1ykZXcoCzOssyJ5ud4FmkKa
         IaMTygKYDskYf18EelnPYwNcvtJjDkIa16gZfRhHjvKPdQ4/t0xUu+iZW3cs06kpdGXG
         MVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698314201; x=1698919001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIHrwT1IPJSaVwo9toEDHyrvoQFfktSqXsqS3njZKmY=;
        b=b7NEtOnYhGgr8ePRmHk+BOJn946ZHYyplWyvM5p4xGSTfjjm24VdDSA86gHRhsvbQf
         DOL2AoOUFjf2H86TNIe6KCUrZLOY/2QJ/wQl/k3JlbKVHQP9LArMREyIS15GoeU0IvEi
         l3KqC8+T/GpZytY3KOkio7Os6kJoilAuptVANj08IzjQ5nvtBaEAlDw7m7pxStYq/vLT
         LUlbfsztLgxhrw/fheWfO6yne8gVR7RXK1j2RhYK+ySnE6pVMQvjPTVZjzXi/GFCF99L
         5JjuLv5wMVl/jjmxnaNawZWfsr1lk2NpDwkW7/1XX7P0UbWDTM4zd30gDR0JwVeWS1Il
         Upfg==
X-Gm-Message-State: AOJu0Yz82UL4a7/eQOsh87EY4Z9ALzUJeICjOJNrxcz4mEsiKyNb6Q2E
        ABWT7vD48F65RtRQGtMhWs8=
X-Google-Smtp-Source: AGHT+IGtf29HTCS4vL+Y3AWJnjV7GZMqO3o0uHhE7d85x7B61jHNbHPFH7TpxYlEaXNI+XJ32j4Yig==
X-Received: by 2002:a05:6512:3e0d:b0:4ff:b830:4b6b with SMTP id i13-20020a0565123e0d00b004ffb8304b6bmr17178751lfv.14.1698314200473;
        Thu, 26 Oct 2023 02:56:40 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id o13-20020ac24bcd000000b00507a622184dsm2958861lfq.173.2023.10.26.02.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 02:56:39 -0700 (PDT)
Message-ID: <a0636e8e-7a39-4c58-8dee-7187ffd7fc63@gmail.com>
Date:   Thu, 26 Oct 2023 12:56:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: correct file entry IIO LIGHT SENSOR
 GAIN-TIME_SCALE HELPERS
To:     Amit Dhingra <mechanicalamit@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <CAO=gReHuuwB6mBZAXpYHGk9XsWE8e8+U3T9e6iqCXYQMcjZZVg@mail.gmail.com>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAO=gReHuuwB6mBZAXpYHGk9XsWE8e8+U3T9e6iqCXYQMcjZZVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/26/23 11:33, Amit Dhingra wrote:
> Commit ca11e4a35154 ("MAINTAINERS: Add IIO gain-time-scale helpers"),
> updates the MAINTAINERS file. However the files listed do not exist.
> These presumably come from commit 38416c28e168 ("iio: light: Add
> gain-time-scale helpers")
> 
> Fix the entries.
> 
> Found by ./scripts/get_maintainer.pl --self-test=patterns
> 
> Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a493d96ffd85..6dd44ec48886 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10287,8 +10287,8 @@ IIO LIGHT SENSOR GAIN-TIME-SCALE HELPERS
>   M:	Matti Vaittinen <mazziesaccount@gmail.com>
>   L:	linux-iio@vger.kernel.org
>   S:	Maintained
> -F:	drivers/iio/light/gain-time-scale-helper.c
> -F:	drivers/iio/light/gain-time-scale-helper.h
> +F:	drivers/iio/industrialio-gts-helper.c
> +F:	include/linux/iio/iio-gts-helper.h

Thanks a lot Amit!
Seems like the very old file names were left in here.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

> 
>   IIO MULTIPLEXER
>   M:	Peter Rosin <peda@axentia.se>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

