Return-Path: <linux-iio+bounces-21809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B465DB0C244
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8422A18C33CD
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8007329A31A;
	Mon, 21 Jul 2025 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WjIwYztp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345AA293C56
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096146; cv=none; b=es/Z2pA/kke0tqyX53F843M+UeCnomxNcbcp3Nt7rD65En/kLIwgHbDhd+F15YneAeOtzQKuOv1lbbESnJEsqdLwTsqI3QvDOjr2xojIMiU/JLN7P41rN/3KYVT56mVgO79v4tvC8S0B5YrguzqmcnprDf/UXPI0lqJQcRw046g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096146; c=relaxed/simple;
	bh=SsD61A8hR5q9MQ8QKFckZ6cN9hCMs+AKO11xNPKYjkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/ZyOd+RCodER9+VQmSEKIiLFPvJETxl1nzB2N3k0oJv1rh+5p2daobXRS65j9SG/Ux7DjtXrHXzpHZf24kzufq8Mb7IFrSIFt/X6PQk5rFX1juHIHldMV40Qz189C/kosBo9z619PKkOvy5CN9DRR+hd7cdRyxgX7lXLO+4G90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WjIwYztp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45619d70c72so39483255e9.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 04:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753096141; x=1753700941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmtXN5LOpsy9wnbFF88f1TFJAOYpmO6pOglF7c6OjGE=;
        b=WjIwYztphIyNa3/uYZOZTtxJcn7ek7HtPzVIWEzMj0zXwnLZfy5p3X72oOCPdJzP2V
         uiIa2taSc2Gb3PIvaNbDVedfyUPhT1IdGGFnl11ayRDQlOcyw5pLovDkCrV33b+TynG+
         fJuSXgYxR5xGpyqN2YGXNYqV0buURma4ZGlDStiMkOZjTTLUUtXP8fp8S2vK582ZufQT
         YybMsb6p/+q3+jTw+8xI67H2uGWWnYQUixh9zsBE1zwABUwgLLOPW7LLck8f9E89T0pm
         6tLCcTHk4KaLmgZaLVOGOw7M7g2oBiFtZTpQOCSa10CCfNxnhEI+Mi8pTG1U6uREzA4p
         ffEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096141; x=1753700941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmtXN5LOpsy9wnbFF88f1TFJAOYpmO6pOglF7c6OjGE=;
        b=HtYdCglRdkfr8kaq4Hr51zym23/jHu7mbjYsEVWKmZxVl0oSq440mQ/44QHwkAsVgg
         cVzlAzxYfqxQCAn1kh7aT9SFvlBaiNhEy4MsOjLy8U9LJDURRt9BC4PHcan/Rfzkuecb
         6q8GFfUjOwEvlCfjLKvPErP4KlGxs2zM58eWxs3ljmb+mhJ/QlayAj31b/YeeRQPynxx
         RyK3dhvB6RPsTgAmJOfT/cHV/nSs0qQT/sDkE8+zznCvWJUkgxNustCcVJqk3ucxv059
         VKPKRr2MPOXWVyxiMkFGrad8RiKc7HK20oKCdyYcmRaANZVYV8EEDmC5Wmvdg9BBqs1n
         VHNg==
X-Forwarded-Encrypted: i=1; AJvYcCXixx1fUgRxZUO4OGhEww6Y/6b8jsegBOmeSwrnkYWwPMyx6I3qfFcLBo3qDVbQDqlfs1Q8WMNbGfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0d/R7Smsl8FERyNFscs+bfb3OzMB3RqXloxHfNK/3Lq7dw3uu
	EMoUZlwDEPar5ECpkyjUjYiaeikYVi2Rqv/xlxbly58W3xPFHGZczfum9xN5M3PXGEnlYKVk2JB
	eyanv
X-Gm-Gg: ASbGncs6ocjXjgFn41hZ2tIwF+phGYoKPK/WoY6MvbARgd/kqDshEj0ysFI75Rv04CB
	Z39DqJ2iQERBs2Lluh/r5p4lX6BUNsYFnVQi6NUAzBCUsKVfzExaIFKA6cYrdD+G9OgZpMgd/zG
	y0zCVKFm6TDqHVxjv+L1XQr+GF6wa7DRwfI78mAB5D1HfA3g5qlnLBe7loszJ8nnRuloWoo/vkz
	GnPlFI0NbhyxsLgCrHYeH342fbWVnEl37QNz/xKmZW4AuRP/7s33Wz4tcAWBdLX4w9gEvBlGxXR
	bY9+iRqifCs14n8Rgdhu3hFjL/uvdOeb1i0DnRamQMOjemVSJbVXlIACJg5SdhdIr3IzbyuCQkm
	pK1lTbDFi65e/P+o49UCG+1l/nWFCdIbOBox0EPuk5lCJAbzWpdN2v35GW0v+ul4=
X-Google-Smtp-Source: AGHT+IF/p9/8BzW3lB8bZPpYYHRczY58A+Ne9dELqgeiVrztj+TKGERiYVH004vi+cnHyij4U7BDBg==
X-Received: by 2002:a05:600c:c4a6:b0:455:f7b8:235c with SMTP id 5b1f17b1804b1-456348c644emr159193895e9.14.1753096141413;
        Mon, 21 Jul 2025 04:09:01 -0700 (PDT)
Received: from [192.168.1.36] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c813sm10201962f8f.84.2025.07.21.04.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 04:09:00 -0700 (PDT)
Message-ID: <68251793-d1d2-4f7d-be00-a47a4fd5f80e@linaro.org>
Date: Mon, 21 Jul 2025 13:08:59 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] QRTR bus and Qualcomm Sensor Manager IIO drivers
Content-Language: en-US
To: y.oudjana@protonmail.com, Manivannan Sadhasivam <mani@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yassine,

On 10/07/2025 10:06, Yassine Oudjana via B4 Relay wrote:
> Sensor Manager is a QMI service available on several Qualcomm SoCs which
> exposes available sensors and allows for getting data from them. This
> service is provided by either:
> 
> - SSC (Snapdragon Sensor Core): Also known as SLPI (Sensor Low Power
>   Island). Has its own set of pins and peripherals to which sensors are
>   connected. These peripherals are generally inaccessible from the AP,
>   meaning sensors need to be operated exclusively through SSC. The only
>   known SoCs in this category are MSM8996 and MSM8998 (and their
>   derivatives).
> - ADSP (Audio DSP): Shares pins and peripherals with the AP. At least on
>   some devices, these pins could be configured as GPIOs which allows the AP
>   to access sensors by bit-banging their interfaces. Some SoCs in this
>   category are SDM630/660, MSM8953, MSM8974 and MSM8226.
> 
> Before Sensor Manager becomes accessible, another service known as Sensor
> Registry needs to be provided by the AP. The remote processor that provides
> Sensor Manager will then request data from it, and once that process is
> done, will expose several services including Sensor Manager.

arguably a bit of a nit pick, but it might be worth clarifying that
newer SoCs starting with sdm845 also work in much the same way, except
the actual data is packed into protobuf messages which are sent over
QMI, rather than using QMI itself for the sensor data (and hence aren't
supported by this series).

That said, this is really awesome :D

Kind regards,>
> This series adds a kernel driver for the Sensor Manager service, exposing
> sensors accessible through it as IIO devices. To facilitate probing of this
>  driver, QRTR is turned into a bus, with services being exposed as devices.
> Once the Sensor Manager service becomes available, the kernel attaches its
> device to the driver added in this series. This allows for dynamic probing
> of Sensor Manager without the need for static DT bindings, which would also
> not be ideal because they would be describing software rather than
> hardware. Sensor Manager is given as a working example of the QRTR bus.
> Kernel drivers for other services may also be able to benefit from this
> change.
> 
> As previously mentioned, a Sensor Registry server must run on the AP to
> provide the remote processor (either SLPI or ADSP) with necessary data.
> A userspace implementation of this server is made[1]. The server can be
> supplied with the necessary data in the form of a plain-text configuration
> file that can be pulled from the Android vendor partition (sample[2]), or
> generated from a binary file that can be pulled from the persist partition.
> A more recently developed kernel implementation of the Sensor Registry
> server[3] can also be used. This last implementation only supports reading
> data from the binary file pulled from persist. Sensor Registry remains out
> of the scope of this patch series, as the Sensor Registry server and Sensor
> Manager client (this series) are fully independent components.
> 
> Due to the total lack of documentation on Sensor Manager, this driver was
> almost entirely the result of a process of capturing transactions between
> SSC and the proprietary Android daemons with several methods and manually
> decoding and interpreting them, sometimes by comparing with values acquired
> from Android APIs. A blog post[4] describes part of this process more
> detail. A little piece of downstream Android open-source code[5] was also
> used as reference during later stages of development. All of this, as well
> as a lack of time on my side for the last couple of years, meant that this
> driver had to go through a slow and intermittent development process for
> more than 3 years before reaching its current state.
> 
> Currently supported sensor types include accelerometers, gyroscopes,
> magentometers, proximity and pressure sensors. Other types (namely
> light and temperature sensors) are close to being implemented.
> 
> Some testing instructions may also be found here[6].
> 
> [1] https://gitlab.com/msm8996-mainline/sns-reg
> [2] https://github.com/nian0114/android_vendor_xiaomi_scorpio/blob/mkn-mr1/proprietary/etc/sensors/sensor_def_qcomdev.conf
> [3] https://github.com/sdm660-mainline/linux/pull/57
> [4] https://emainline.gitlab.io/2022/04/08/Unlocking_SSC_P2.html
> [5] https://android.googlesource.com/platform/system/chre/+/android-8.0.0_r2/platform/slpi
> [6] https://gitlab.postmarketos.org/postmarketOS/pmaports/-/merge_requests/4118
> 
> Changes since v1:
> - Split qdev renaming into separate patch
> - Export new QRTR symbols with namespace
> - Change struct initialization style
> - Remove redundant NULL initialization of qdev->dev.driver
> - Remove redundant devm_kfree
> - Use variable in sizeof rather than type
> - Change error return style in qcom_smd_qrtr_init
> - Change order of operations in qcom_smd_qrtr_exit
> - Use FIELD_PREP and GENMASK in QRTR_INSTANCE macro and add a CONST variant
> - Remove per-sensor subdrivers and eliminate use of platform devices
> - Put year range in copyright statements
> - Use dev_err_probe for error messages in probe
> - Remove unused include of linux/of.h
> - Avoid casting away const in qcom_smgr_buffering_report_handler
> - Use iio_push_to_buffers instead of iio_push_to_buffers_with_timestamp
> - Preprocess proximity sensor data before pushing to buffer
> - Add warning message for report with unknown ID received
> - Change sentinel value style in array of struct initialization
> - Refuse to set sampling frequency when buffer enabled
> - Return -EINVAL inside default case in all applicable switch statements
> - Move samp_freq_vals in qcom_smgr_iio_read_avail to priv and fix maximum
> - Add devm_add_action_or_reset for releasing QMI handle and get rid of
>   qcom_smgr_remove
> - Add service versions and instance IDs found on some platforms to QRTR
>   match table
> - Fix null pointer dereference on registering unsupported sensor
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Yassine Oudjana (4):
>       net: qrtr: smd: Rename qdev to qsdev
>       net: qrtr: Turn QRTR into a bus
>       net: qrtr: Define macro to convert QMI version and instance to QRTR instance
>       iio: Add Qualcomm Sensor Manager driver
> 
>  MAINTAINERS                                     |  13 +
>  drivers/iio/accel/qcom_smgr_accel.c             | 138 ++++
>  drivers/iio/common/Kconfig                      |   1 +
>  drivers/iio/common/Makefile                     |   1 +
>  drivers/iio/common/qcom_smgr/Kconfig            |  16 +
>  drivers/iio/common/qcom_smgr/Makefile           |   8 +
>  drivers/iio/common/qcom_smgr/qcom_smgr.c        | 840 ++++++++++++++++++++++++
>  drivers/iio/common/qcom_smgr/qmi/Makefile       |   3 +
>  drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.c | 713 ++++++++++++++++++++
>  drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.h | 161 +++++
>  drivers/soc/qcom/qmi_interface.c                |   5 +-
>  include/linux/iio/common/qcom_smgr.h            |  80 +++
>  include/linux/mod_devicetable.h                 |   9 +
>  include/linux/soc/qcom/qrtr.h                   |  46 ++
>  net/qrtr/af_qrtr.c                              |  23 +-
>  net/qrtr/qrtr.h                                 |   3 +
>  net/qrtr/smd.c                                  | 252 ++++++-
>  scripts/mod/devicetable-offsets.c               |   4 +
>  scripts/mod/file2alias.c                        |  10 +
>  19 files changed, 2302 insertions(+), 24 deletions(-)
> ---
> base-commit: 835244aba90de290b4b0b1fa92b6734f3ee7b3d9
> change-id: 20250710-qcom-smgr-8db96d370b10
> 
> Best regards,

-- 
// Casey (she/her)


