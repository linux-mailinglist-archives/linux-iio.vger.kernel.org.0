Return-Path: <linux-iio+bounces-21810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92168B0C25B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381A418C3418
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9294F298996;
	Mon, 21 Jul 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3yCEvZ/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC2D2980D6
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096433; cv=none; b=ZDPeItk40P5wZDS+3rBEbpFzyoSy4q7/dPOOCA5PtvUPgKdj6kADo5gBUC9Nzpz04SJZUEjIBqeQ9pf35Fve30EfgnIy47OymJauZUY0lHqiaSuhCWXzWq620HWy8ddSJCbuuQ4qSEVI1kS3Kwls1R8+S5MNgyF5Q9yZj95jKnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096433; c=relaxed/simple;
	bh=3LePUhZLqMHmMSA1GfKcOrJBLnHS9teMOpXWN0q2aMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EX0IU39W6e3VRtfEty1C01q+Vxe7ZjcPIfin5EzhLFPoXvBA52ncjsPz7bMTeUKlmFnZxmYs8XzihNUcbGkazsz01JFrnaWjrsFIVqt6BQODRltnZyDurZbnTJwdzQXN4OhRM33SgpyXw7ZPi7Hds1VR4qlSX0k7G6z/u0wIfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K3yCEvZ/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a522224582so2062050f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 04:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753096430; x=1753701230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCpk9GjmCqOqyvs+4Z7EUdmuqAEP2pxTsgkUzsyKDEo=;
        b=K3yCEvZ/DbLZYArDvEFschm5fG6TaXd8DDVie+6xzKntLEHLI50c92iV1XvGo/Us/G
         YIGoG0XHQJ8sShww3CwVnfdJeWTs3cbYiHWqsZJzT0vc0V28hXKGoswRBQOIT7A9gAu/
         eqfSk+5iGhP1jbfWlsazv28vw1HgAYRyvddIsBhdHW2MNtcdZ0MfSY0xE1DF4+IrchNp
         XMo8lto8Uym1MQ17aBusYX10uuv3gP0xfIrUyM9kypeCFsuwyUG7GYGBWKOFqnK/kX2w
         oVc8zYWRxQs4/qGLEvT8wMbuyhce06N6uTqdmdoBMxn4fLIk1BR8CyuTKMnxaqfTCk5f
         Jv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096430; x=1753701230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCpk9GjmCqOqyvs+4Z7EUdmuqAEP2pxTsgkUzsyKDEo=;
        b=r93etMGoNOFU2VX/Mv5/afXHpCo0dedCJJDq+TJpjDAfsLpr2HFghAF/zhiRx/v9Ps
         f3WRvSpp0GN1OdPbsuJojNk88jZpf0vKeP6rudR7AclNlelFHMTWueTytdIjUdn0jj3l
         zIujts2fbwRLnKPTOKOPihlEIXmbXPTZOLlDhT6ZdNjOCzTQzv9x/z66Jv0r966fkUrk
         PmId73tFQ26+iW3FV9R45l8Hum1WIVSQMBnPYfYnEOwJgSC7XwINTHvo0cB7OozqfPJQ
         kN4JR0n6oAPOir0z6qJxoZxDfu7V00lDMJLiWW7KLvlaBZCXYQpc+/VE8t4PepJP8L5q
         lyGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFjZYbtToTb2JP+Wj6tdQFPtIKSAV28OB2moY/AV3ZUVLsq+fNasE2uEtTdgPDS1zOPw9rqjnqDFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpB1ZIwZaWM0Vi3alytcvS9ah20gCjPhK6QeYVsaKAjjSlWfh4
	dZ/MKUBzx58WzxXL9cYkk+SCEXnSATP9UthL2FyVTpzNEstE2HotcM2CG5eza+68Dig=
X-Gm-Gg: ASbGncsAOKN6mvv37ilNRavYhlZLnf5Q9LivEwAFJTfqDHC/iMCwK1rI34YRzX5+hBy
	zOZw8+ejkqNy/tKnB2/DtQ6OTtfe2Lr7Z9P8r8uVvPf8Nf/ylHauGXSE69Wh+lsdCocQEpxzFxJ
	0aXuJl/wyxY0LxGWvjZExF4p1Nov9sdJbcJ+41/mgKebHa2eKwpB639Ff0kDh293COE8MtpYQAo
	xxtpkJw6rtNV3vwgAhhnx5mNZ8reQdO0i5QT1TRb2nRMcKeH4pmQXlaDPzt36D/mPk63gcYyvw4
	YPucvKt5Ntn0K2vlb//uDL5YswsXVwwXmFpgQeZJy/VvtevfAvspbBZJdRCRacSQ+k7LYgNU06T
	lvnO06FkBpjhm6lGp/YgrMdgykHVr+yHYDDZkZzXv7rpT6jiopJzFSINpKAgyC9o=
X-Google-Smtp-Source: AGHT+IGphSZ4nqGy3QQspzTFvacskBSUZG+3aCT88SVK0C+HxQ5ng+J8deaVhU6sjyoaTxsnS6cTNg==
X-Received: by 2002:a05:6000:144a:b0:3a8:310a:b1dc with SMTP id ffacd0b85a97d-3b60ddc64e3mr16113819f8f.56.1753096429728;
        Mon, 21 Jul 2025 04:13:49 -0700 (PDT)
Received: from [192.168.1.36] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c9e2sm10284808f8f.89.2025.07.21.04.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 04:13:49 -0700 (PDT)
Message-ID: <b38accf6-c7f5-4728-9507-2d380207935f@linaro.org>
Date: Mon, 21 Jul 2025 13:13:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: Add Qualcomm Sensor Manager driver
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
 <20250710-qcom-smgr-v2-4-f6e198b7aa8e@protonmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250710-qcom-smgr-v2-4-f6e198b7aa8e@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yassine,

On 10/07/2025 10:06, Yassine Oudjana via B4 Relay wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a driver for sensors exposed by the Qualcomm Sensor Manager service,
> which is provided by SLPI or ADSP on Qualcomm SoCs. Supported sensors
> include accelerometers, gyroscopes, pressure sensors, proximity sensors
> and magnetometers.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
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
>  include/linux/iio/common/qcom_smgr.h            |  80 +++
>  11 files changed, 1974 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b5a472a544cfe2ad87691209c34d7bafe058ba42..0fb91c9bce431fc899776ff10b728ecdc957f51a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20702,6 +20702,19 @@ F:	Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
>  F:	drivers/net/ethernet/qualcomm/rmnet/
>  F:	include/linux/if_rmnet.h
>  
> +QUALCOMM SENSOR MANAGER IIO DRIVER
> +M:	Yassine Oudjana <y.oudjana@protonmail.com>
> +L:	linux-iio@vger.kernel.org
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained

Missing drivers/iio/accel/qcom_smgr_accel.c here

Kind regards,

-- 
// Casey (she/her)


