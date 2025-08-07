Return-Path: <linux-iio+bounces-22382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B692B1D42A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 10:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8DA3B4522
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBF723BCF8;
	Thu,  7 Aug 2025 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfmSIRRz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9761978F3A
	for <linux-iio@vger.kernel.org>; Thu,  7 Aug 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554599; cv=none; b=X1EVXzDXZ/knVIE/5m0Ryuy1eEdMjM+r7aETvBH5efy0zcpQwxSpTCsUgLrKq+BTwfRXQtZwgxTF+7xb/z7PZYvb1XHz8y3/Z06G3p+VqqIXlg74AdmvPDtnpjeKk5Pa38ITbWzA5BTa/VTNql38hhGzZ2pG0sbIxbeniOIiZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554599; c=relaxed/simple;
	bh=dFOCs/dZnxDMo/hiV3S9cs/4YKTmqRjh35ydSHNhZkY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YWHGq/wKKUNVEPgUxclq85aL/7zbrBLz4ciMuEmHUQt+fvoFpjbdcU/trscdzd0kDqfJmzy9lDCc6h2JkkoUcmq1Cp6LM/muXP30z32yabvfCTqnXLbzrh0/6Ul5X/5rDMR4ljGhxJYEb5GOsUEX+MHmKHk5dnl36g5IGgJVxuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LfmSIRRz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459e210bd2dso5915185e9.1
        for <linux-iio@vger.kernel.org>; Thu, 07 Aug 2025 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754554595; x=1755159395; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0VW7sNoEVN9Oek4Y6iCLkY+7OPvY5tDfJvOxUwPm/i8=;
        b=LfmSIRRzuMeua22vlIO6OuuQWSZNTPhWY4Xdl1C6msZgiKLSIl9K/IK2Xb57yBqKbz
         p3Hk+akhUesvTniXhlKSdsUmC8204Q0vYP1am7x5dKJ09w893z2k1aFOnIQG/4h5Kf8d
         n+OX8MY0qL5o3zQm5XXUHO/bpZDrqXjsgiGAnzowduFoYaDRarFjyCpMua6uDv0TfTAM
         cxPD25qvMziLXeNJG7EP/HzLjKpHnpqatjOyEiN4vtioGwWnfQoCM6Px2JZ4g3G59WM+
         Lrdf43fApvgcSeJ78QS1AOazw3ly40BYDRmPNX6Mn7fRmdm/JQxdtvPn0GQXlSn9iCFh
         /pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754554595; x=1755159395;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0VW7sNoEVN9Oek4Y6iCLkY+7OPvY5tDfJvOxUwPm/i8=;
        b=KalbpiJqyZJPOgR/J3s+hlr4icdNXigJbj3bpHZiQpc2QMkgqPgcJERalsM4+9jaUR
         ASyp2Lr4uzGKMP/lhJYeJxIAjERmJNGNmdBxquxv418uI1lqRLgxVfIMMPsq51wGYjI4
         kPaxj1Giu+rzDlV+OArQTQ9hGen7+zBakE2MOzjlVwQE2eQsjJJfzkqfdtj9tDTev15i
         MwsdbOrzOetaovfKyt2WPRhz+IOK3ABLYVr+zHrzIyoOe+7aXMrGuCP5lWpMKTrCDD9g
         qwonD3COMKSVaYYmPVrBHFcxW7sQxeEdyy58RsG6fFvm5Z7Xq8L6wIga3dzV6q2Vd1Ef
         BR3w==
X-Forwarded-Encrypted: i=1; AJvYcCXCFgVaCAGDVomErC5CuJw4+z9q/Qi6PARKo0hFf0fmXy218DOrwPOl0awShOggTdtyZfq3N8rxSjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzx8SKplP5ZtMiq5gEbiUPNxOyFj7ECotH24hpV7f1ZeL5FcDO
	NFAU6Xx+Z1+2bXCYMfR3ytaz9uplIPcWJwZGCse3AFe5gBIqBAFZo/9mR4hHEoUpS4s=
X-Gm-Gg: ASbGncsqj8cEZfMknJ4WNFCfPkbgvN+0c2kX67bPLhalvFAymsSx3GIGB623QhrRLdd
	3XgKbVOZnD6EPFrKd2vyESnScqDUjQckEfz6Nq8tTuRctwrgpT4XdQYm57y/iAW3sk319CKYYL8
	8jbSkg2W6u4nCrbMP5FSupDS9HsBSX0+EK0SngxRJ+D7et2M18L3sl/NVlj1MU95YyHP5uF6EpX
	CK+E+pYiVS3k2NStNlYePdS0UlMxSHEJZjK4uNuvLSpjeiJqv0i+kBDDb/rw+DNMv2AtHZIfVBJ
	5PVzOWAcZ3z4u8y7H/df5u/7+AXDAFC1obq27+LhhhXmtTE+Sfoy1t7gYBhQTfAf7LrSIjmXTY2
	21MtpcMTp8h8DXKKeKf5m7Xz9aT/f4QHxUFRSwNuvnXaPn5ILq/4zQoMNxLJwVeuYXpS3JUyIni
	ejEY5MtD5uww==
X-Google-Smtp-Source: AGHT+IHf76mdyLCfSs/m6kb0Yuf0hOwdsPWIFudkvQQwFH25PcMEQes2ysVoYmJDxQgMxeQSTlqZ2Q==
X-Received: by 2002:a05:600c:3f1a:b0:453:6c45:ce14 with SMTP id 5b1f17b1804b1-459ede93ea5mr23251335e9.4.1754554594862;
        Thu, 07 Aug 2025 01:16:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:5bf9:b40c:d741:ea95? ([2a01:e0a:3d9:2080:5bf9:b40c:d741:ea95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587e154sm89875075e9.27.2025.08.07.01.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 01:16:34 -0700 (PDT)
Message-ID: <7c3d9e84-d14f-4cf0-b376-6fdde6f586f5@linaro.org>
Date: Thu, 7 Aug 2025 10:16:33 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 0/7] SPMI: Implement sub-devices and migrate drivers
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 sboyd@kernel.org
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org,
 krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
 casey.connolly@linaro.org
References: <20250730112645.542179-1-angelogioacchino.delregno@collabora.com>
Content-Language: en-US, fr
In-Reply-To: <20250730112645.542179-1-angelogioacchino.delregno@collabora.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2025 13:26, AngeloGioacchino Del Regno wrote:
> Changes in v3:
>   - Fixed importing "SPMI" namespace in spmi-devres.c
>   - Removed all instances of defensive programming, as pointed out by
>     jic23 and Sebastian
>   - Removed explicit casting as pointed out by jic23
>   - Moved ida_free call to spmi_subdev_release() and simplified error
>     handling in spmi_subdevice_alloc_and_add() as pointed out by jic23
> 
> Changes in v2:
>   - Fixed missing `sparent` initialization in phy-qcom-eusb2-repeater
>   - Changed val_bits to 8 in all Qualcomm drivers to ensure
>     compatibility as suggested by Casey
>   - Added struct device pointer in all conversion commits as suggested
>     by Andy
>   - Exported newly introduced functions with a new "SPMI" namespace
>     and imported the same in all converted drivers as suggested by Andy
>   - Added missing error checking for dev_set_name() call in spmi.c
>     as suggested by Andy
>   - Added comma to last entry of regmap_config as suggested by Andy
> 
> While adding support for newer MediaTek platforms, featuring complex
> SPMI PMICs, I've seen that those SPMI-connected chips are internally
> divided in various IP blocks, reachable in specific contiguous address
> ranges... more or less like a MMIO, but over a slow SPMI bus instead.
> 
> I recalled that Qualcomm had something similar... and upon checking a
> couple of devicetrees, yeah - indeed it's the same over there.
> 
> What I've seen then is a common pattern of reading the "reg" property
> from devicetree in a struct member and then either
>   A. Wrapping regmap_{read/write/etc}() calls in a function that adds
>      the register base with "base + ..register", like it's done with
>      writel()/readl() calls; or
>   B. Doing the same as A. but without wrapper functions.
> 
> Even though that works just fine, in my opinion it's wrong.
> 
> The regmap API is way more complex than MMIO-only readl()/writel()
> functions for multiple reasons (including supporting multiple busses
> like SPMI, of course) - but everyone seemed to forget that regmap
> can manage register base offsets transparently and automatically in
> its API functions by simply adding a `reg_base` to the regmap_config
> structure, which is used for initializing a `struct regmap`.
> 
> So, here we go: this series implements the software concept of an SPMI
> Sub-Device (which, well, also reflects how Qualcomm and MediaTek's
> actual hardware is laid out anyway).
> 
>                 SPMI Controller
>                       |                ______
>                       |               /       Sub-Device 1
>                       V              /
>                SPMI Device (PMIC) ----------- Sub-Device 2
>                                      \
>                                       \______ Sub-Device 3
> 
> As per this implementation, an SPMI Sub-Device can be allocated/created
> and added in any driver that implements a... well.. subdevice (!) with
> an SPMI "main" device as its parent: this allows to create and finally
> to correctly configure a regmap that is specific to the sub-device,
> operating on its specific address range and reading, and writing, to
> its registers with the regmap API taking care of adding the base address
> of a sub-device's registers as per regmap API design.
> 
> All of the SPMI Sub-Devices are therefore added as children of the SPMI
> Device (usually a PMIC), as communication depends on the PMIC's SPMI bus
> to be available (and the PMIC to be up and running, of course).
> 
> Summarizing the dependency chain (which is obvious to whoever knows what
> is going on with Qualcomm and/or MediaTek SPMI PMICs):
>      "SPMI Sub-Device x...N" are children "SPMI Device"
>      "SPMI Device" is a child of "SPMI Controller"
> 
> (that was just another way to say the same thing as the graph above anyway).
> 
> Along with the new SPMI Sub-Device registration functions, I have also
> performed a conversion of some Qualcomm SPMI drivers and only where the
> actual conversion was trivial.
> 
> I haven't included any conversion of more complex Qualcomm SPMI drivers
> because I don't have the required bandwidth to do so (and besides, I think,
> but haven't exactly verified, that some of those require SoCs that I don't
> have for testing anyway).
> 
> AngeloGioacchino Del Regno (7):
>    spmi: Implement spmi_subdevice_alloc_and_add() and devm variant
>    nvmem: qcom-spmi-sdam: Migrate to devm_spmi_subdevice_alloc_and_add()
>    power: reset: qcom-pon: Migrate to devm_spmi_subdevice_alloc_and_add()
>    phy: qualcomm: eusb2-repeater: Migrate to
>      devm_spmi_subdevice_alloc_and_add()
>    misc: qcom-coincell: Migrate to devm_spmi_subdevice_alloc_and_add()
>    iio: adc: qcom-spmi-iadc: Migrate to
>      devm_spmi_subdevice_alloc_and_add()
>    iio: adc: qcom-spmi-iadc: Remove regmap R/W wrapper functions
> 
>   drivers/iio/adc/qcom-spmi-iadc.c              | 109 ++++++++----------
>   drivers/misc/qcom-coincell.c                  |  38 ++++--
>   drivers/nvmem/qcom-spmi-sdam.c                |  37 ++++--
>   .../phy/qualcomm/phy-qcom-eusb2-repeater.c    |  51 +++++---
>   drivers/power/reset/qcom-pon.c                |  34 ++++--
>   drivers/spmi/spmi-devres.c                    |  24 ++++
>   drivers/spmi/spmi.c                           |  79 +++++++++++++
>   include/linux/spmi.h                          |  16 +++
>   8 files changed, 278 insertions(+), 110 deletions(-)
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

Tested patch 1, 2, 3 & 4, I can see the :
/sys/kernel/debug/regmap/0-00.0.auto
/sys/kernel/debug/regmap/0-00.1.auto
/sys/kernel/debug/regmap/0-07.2.auto

And it still functional.

Neil


