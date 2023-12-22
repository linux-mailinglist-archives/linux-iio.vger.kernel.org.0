Return-Path: <linux-iio+bounces-1229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2481CE73
	for <lists+linux-iio@lfdr.de>; Fri, 22 Dec 2023 19:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577511F22E9B
	for <lists+linux-iio@lfdr.de>; Fri, 22 Dec 2023 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E322C1A9;
	Fri, 22 Dec 2023 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAhYc/yL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E92C196;
	Fri, 22 Dec 2023 18:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFBFC433C8;
	Fri, 22 Dec 2023 18:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703269665;
	bh=jBq9Spzdcu2O8tozQzt3qro+Hc8ZCBz9msYeevvGov4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NAhYc/yL4nPXHaZxpww12ejmgPLYARUmsmPSjh0wE+OM9OYTseRA7ZjakcC0qb/HW
	 +OxuSzRtIbeAXuPaNTpbf2HfyWwX7aKYnKMv9XYOyifOhmFDwzqP38XJceMk6uFFIj
	 u+JCSa76kaHmUpn1ctMn1F8HzgO1BuBahXvONcdrJqCxx9O0UmIIfqffD4CEpspSYF
	 Gb8zYibiQTXr1CRUgBydOvXWMWACWC5QwE2c8aEVnz06Gf/ZnIYlfhKDC+4YzaVfnZ
	 wwi6WtTolgErLDgAAfoUQA1GtKJgFN8gdfWIF4wm0ROlAv8P3JDRCIJr6z+HYEPPE4
	 t7umGkk8ZXDWg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 Yauhen Kharuzhy <jekhor@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, 
 linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
In-Reply-To: <20231219231503.1506801-1-jekhor@gmail.com>
References: <20231219231503.1506801-1-jekhor@gmail.com>
Subject: Re: [PATCH] HID: sensor-hub: Enable hid core report processing for
 all devices
Message-Id: <170326966337.2018208.16515231674277786077.b4-ty@kernel.org>
Date: Fri, 22 Dec 2023 19:27:43 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

On Wed, 20 Dec 2023 01:15:03 +0200, Yauhen Kharuzhy wrote:
> After the commit 666cf30a589a ("HID: sensor-hub: Allow multi-function
> sensor devices") hub devices are claimed by hidraw driver in hid_connect().
> This causes stoppping of processing HID reports by hid core due to
> optimization.
> 
> In such case, the hid-sensor-custom driver cannot match a known custom
> sensor in hid_sensor_custom_get_known() because it try to check custom
> properties which weren't filled from the report because hid core didn't
> parsed it.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.8/sensor-hub), thanks!

[1/1] HID: sensor-hub: Enable hid core report processing for all devices
      https://git.kernel.org/hid/hid/c/8e2f79f41a5d

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


