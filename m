Return-Path: <linux-iio+bounces-22165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E77CB1701D
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 13:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED20C7B02EB
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 11:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305E42BE7BB;
	Thu, 31 Jul 2025 11:05:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15602BE638;
	Thu, 31 Jul 2025 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959936; cv=none; b=ILUvEOfiIZD9AFdNOobdsxwAmC/N0f8PDPIkvro5fxCzNDCG16+ZJLvbqxUkEMRfJYNtV5tDvQ6blmqqeOZM7YCesZvlVntCIhdRaeFN8M77jtJP9I72a+gVopDO/IWjsZBZLijayB4w6L4Aoa2nDDYWHQjGielxjCBSNHx6pek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959936; c=relaxed/simple;
	bh=mVFM8r5cDdwWpwJcXn1oc0Z2uTdcDftzKnpKjrOM2SI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dov+1ZJbeEzNUYHvyJmRrmY93nlU9JRtV4RltcRA5NjkHUFRTovje+4p0b/JETcp0ORFQVFd1Y8/911eUMJDVsXxwOeq8B7xZcf5mJivZr/weK2b+BG1F/FDjMrf4L/Gm4B+j4LRI0npbohEo4nO7wHbx1kLpmEDpfMkJDw3SqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt5mg3ZLkz6D9QX;
	Thu, 31 Jul 2025 19:03:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D7A1E140133;
	Thu, 31 Jul 2025 19:05:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 13:05:23 +0200
Date: Thu, 31 Jul 2025 12:05:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <sboyd@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <srini@kernel.org>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <sre@kernel.org>, <krzysztof.kozlowski@linaro.org>,
	<u.kleine-koenig@baylibre.com>, <linux-arm-msm@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<kernel@collabora.com>, <wenst@chromium.org>, <casey.connolly@linaro.org>
Subject: Re: [PATCH v3 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
Message-ID: <20250731120522.00001005@huawei.com>
In-Reply-To: <20250730112645.542179-2-angelogioacchino.delregno@collabora.com>
References: <20250730112645.542179-1-angelogioacchino.delregno@collabora.com>
	<20250730112645.542179-2-angelogioacchino.delregno@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Jul 2025 13:26:39 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Some devices connected over the SPMI bus may be big, in the sense
> that those may be a complex of devices managed by a single chip
> over the SPMI bus, reachable through a single SID.
> 
> Add new functions aimed at managing sub-devices of a SPMI device
> spmi_subdevice_alloc_and_add() and a spmi_subdevice_put_and_remove()
> for adding a new subdevice and removing it respectively, and also
> add their devm_* variants.
> 
> The need for such functions comes from the existance of	those
> complex Power Management ICs (PMICs), which feature one or many
> sub-devices, in some cases with these being even addressable on
> the chip in form of SPMI register ranges.
> 
> Examples of those devices can be found in both Qualcomm platforms
> with their PMICs having PON, RTC, SDAM, GPIO controller, and other
> sub-devices, and in newer MediaTek platforms showing similar HW
> features and a similar layout with those also having many subdevs.
> 
> Also, instead of generally exporting symbols, export them with a
> new "SPMI" namespace: all users will have to import this namespace
> to make use of the newly introduced exports.
> 
> Link: https://lore.kernel.org/r/20250722101317.76729-2-angelogioacchino.delregno@collabora.com
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
With the note that I know almost nothing about SPMI so am just
looking at what is here + replies in earlier threads.
Looks good to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

