Return-Path: <linux-iio+bounces-24692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F145FBB79BC
	for <lists+linux-iio@lfdr.de>; Fri, 03 Oct 2025 18:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B3D94EE2CF
	for <lists+linux-iio@lfdr.de>; Fri,  3 Oct 2025 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4842D23B8;
	Fri,  3 Oct 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOnIl0/l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C822F2D;
	Fri,  3 Oct 2025 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510118; cv=none; b=dACG4yr3cIKIyl8FVOTJqP++/kwXYyGITb4eNANCZ/jXArFRWP6ntUMqz2zH+8O9OsucR9w6TUcaDhWrHkTjGUIq9UCSzlo9buZjieX0kdKFXcB3ArLlqHnsNBL9fKFkmB9ALCwcuBGw2OPMjsuJ23cu6NAdH872JJjWXtPEDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510118; c=relaxed/simple;
	bh=GzkAbzTVOzOhByob1QiGdkYmNyK/bd9JnxzPtnpywjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooDsNY/uyp4jL25Lb1zuG8GjfQvlfAxPXYWIn3hlcWvReTcQCWRDSTk5JjLH7R4mz0MsdsHmDYk9m79f5/yWDCrv2Qc9RyUZTglQ+nm86qbNzpEmgXgO0iP/bC7FzdiUO+FRiRe3AdlbY2diSoQvoa7bht6QG7lrR7jmyr7z/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOnIl0/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BA9C4CEF5;
	Fri,  3 Oct 2025 16:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759510117;
	bh=GzkAbzTVOzOhByob1QiGdkYmNyK/bd9JnxzPtnpywjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TOnIl0/lNPQNNunLn84iM1jHyKKnJJNx031w8gglGWfO/YdaJLkYKhs+FeOyHbiIR
	 IhBAsk5ooCXr3Y2hHJTplkKD4JIPlQieMHMNx3Rsg513mwd+gcSTvORf3393MJFcDf
	 WqouIp+vklehRqDV2gRzjTiwpm9l2tkv0W84bJSFGYIhWlbrDTLJlhLZnD0l5k7Wz1
	 His0lEPkHJjTAtH2WxlSWY8AoQ6boEwmoRKaTdl5QzRXzEhVR5ITKKBRkNRZuM1jCO
	 3v55Nj5y9/v/xaH10vhTPWYH9u0XjHfTUuGFNiSWotK0o2gML5gPmGc3EKGWGiMHPd
	 QdjCxKVqjKKsQ==
Date: Fri, 3 Oct 2025 17:48:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux@roeck-us.net, rodrigo.gobbi.7@gmail.com,
 naresh.solanki@9elements.com, michal.simek@amd.com,
 grantpeltier93@gmail.com, farouk.bouabid@cherry.de,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 0/5] iio: mpl3115: add support for DRDY interrupt
Message-ID: <20251003174828.6feb3070@jic23-huawei>
In-Reply-To: <20251002200206.59824-1-apokusinski01@gmail.com>
References: <20251002200206.59824-1-apokusinski01@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Oct 2025 22:02:01 +0200
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> Hello,
> This set of patches adds support for the DRDY interrupt in the MPL3115
> pressure sensor. The device has 2 interrupt lines, hence the new
> binding. I also added support for the sampling frequency which
> determines the time interval between subsequent measurements (in the
> continuous measurements mode) so it's obiously tied to the DRDY
> interrupt feature.

Hi Antoni,

LGTM. Applied to the testing branch of iio.git. I'll rebase that on rc1 once
available and then push it out as the togreg branch which linux-next
picks up.

thanks,

Jonathan

> 
> Kind regards,
> Antoni Pokusinski
> 
> ---
> Changes since v3:
> * P2: created mpl3115_fill_trig_buffer
> * P2: trigger_handler: replaced scoped_guard with mutex_lock
> * P2: includes: removed linux/cleanup.h
> 
> * P3: new patch: renamed MPL3115_CTRL_* macros to MPL3115_CTRL1_*
> 
> * P4: extracted the MPL3115_CTRL_* renames into a separate patch (P3 now)
> * P4: trigger_probe: placed devm_request_threaded_irq() call before
>                      devm_iio_trigger_register()
> * P4: trigger_probe: removed switch(irq_cfg_flags) together with the
>                      enum mpl3115_irq_type and added 2 separate
>                      variables to handle interrupt setup logic 
> * P4: set_trigger_state: factored out the CTRL_REG1 and CTRL_REG4 writes 
>                          into a separate function mpl3115_config_interrupt
> 
> * P5: samp_freq_table: added spaces before "},"
> 
> Changes since v2:
> * P4: included linux/bitfield.h
> 
> Changes since v1:
> * P1: add `vdd-supply` and `vddio-supply`
> 
> * P2: new patch: use guards from cleanup.h   
> 
> * P3: change macros of control register bits to convention
>       MPL3115_CTRLX_NAME
> * P3: MPL3115_PT_DATA_EVENT_ALL: use GENMASK
> * P3: trigger_probe: do not fail if dev_fwnode() returns NULL
> * P3: trigger_probe: use devm_iio_trigger_register()
> * P3: trigger_probe: introduced enum mpl3115_irq_type and 
>       changed IRQ setup logic accordingly
> 
> * P4: MPL3115_CTRL2_ST: use GENMASK
> * P4: read_raw: samp_freq: use FIELD_GET
> * P4: write_raw: samp_freq: use FIELD_PREP
> ---
> 
> Antoni Pokusinski (5):
>   dt-bindings: iio: pressure: add binding for mpl3115
>   iio: mpl3115: add separate function for triggered buffer data
>     collection
>   iio: mpl3115: rename CTRL_REG1 field macros
>   iio: mpl3115: add support for DRDY interrupt
>   iio: mpl3115: add support for sampling frequency
> 
>  .../bindings/iio/pressure/fsl,mpl3115.yaml    |  71 ++++
>  .../devicetree/bindings/trivial-devices.yaml  |   2 -
>  drivers/iio/pressure/mpl3115.c                | 331 ++++++++++++++++--
>  3 files changed, 364 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
> 


