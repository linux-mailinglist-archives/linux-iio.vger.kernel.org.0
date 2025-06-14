Return-Path: <linux-iio+bounces-20659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E09AD9D47
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 16:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B929C175F59
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F612DA763;
	Sat, 14 Jun 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSXFBqId"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D85C282E1;
	Sat, 14 Jun 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749909902; cv=none; b=GrJQROK6nEhZhTbHRrBr3LxP+6jnuZ7ma/e+h/Ph6t5u9E2PCRJOasBRS8baH0XZYmzR3ryRorT5RRrHzHMLgk0ezSKvEYvT0xWPmyekRNNWonZOtysLQmiPaDOMUm4US6nYuglOpetj0dz7G+hyDo72CwJ9GgkxBrrSMrh3Pz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749909902; c=relaxed/simple;
	bh=Atsnf5FK0WC8Pj/dCNFfZWGHsQyQjhAUW+if8vrz3kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sniTSA0nVRCHgikO1kp0F064kw1nOeZC5gduZRlFm3l6OlUSBYVu9CUjIuOvMyzVJWOWiQUSKaZyIc+33QvntacH7NhPJ5Cz8ldBl1Dnd/06+Y24EnHx93283zdDU1NX2Kod+pVZXI9GTXX9BD1yXCYR0GSQ9/DMaSwjDc5x/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSXFBqId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB11EC4CEEB;
	Sat, 14 Jun 2025 14:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749909901;
	bh=Atsnf5FK0WC8Pj/dCNFfZWGHsQyQjhAUW+if8vrz3kQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jSXFBqIdIjHXEMZrRoDLXCti0P825DrbiijZTdvAs+zCw8UDaUOB4uwTK+2pAJJjJ
	 1iVxr/VWdITUsD6R9a2hFrv3tk6JaVSvDxlVV9hUyGOr+z+e1D5UCeGYxZHdl5wZ40
	 i7Jld6W1Ree4vVBmYWyZx3fr9Moav/3BjM5AG9QCN0tZjZABwNPdNzagYVxINPE9+O
	 DqzcuOG/kL9AQisTDsefen9IkEIBRhP7SxUD/94/9ZDQGl9AFpU6Uk785b/u5lSpPX
	 SHtkfaqbnM3anKtX58f0F5377M85wW96s4nn/8BObwa1iR5b/Ri4LE96X1wYyXtVUf
	 c+3EwYsp4tOGw==
Date: Sat, 14 Jun 2025 15:04:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 09/11] iio: accel: adxl345: add coupling detection
 for activity/inactivity
Message-ID: <20250614150453.0d249c67@jic23-huawei>
In-Reply-To: <20250610215933.84795-10-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
	<20250610215933.84795-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 21:59:31 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add adaptive coupling activity/inactivity detection by setting the AC/DC
> bit. This is an additional configuration to the activity and inactivity
> magnitude events, respectively. DC-coupled event generation takes the
> configured threshold values directly, where AC-coupled event generation
> references to the acceleration value at the start of the activity
> detection. New samples of acceleration are then compared to this
> reference.
> 
> Both types are implemented using MAG for DC-coupled activity/inactivity,
> but MAG_ADAPTIVE for AC-coupled activity inactivity events. Threshold and
> periods can be configured by different sysfs handles, but share the same
> registers at the sensor. Therefore activity and inactivity,
> respectively, cannot be configured with AC- and DC-coupling at the same
> time, e.g. configuring DC-coupled and AC-coupled activity will result in
> AC-coupled activity, or generally the most recent one being configured.
> 
> This patch implicitly regroups adxl345_read/write_event_value() and
> adxl345_read/write_event_config() where now redundant parts, due to
> similar event handling for AC-coupling, are moved to a separate function
> adxl345_read/write_mag_config() and adxl345_read/write_mag_value(),
> respectively.

Can we introduce these helpers before this patch? It has become rather
hard to read with the code movement and new stuff combined.

Thanks

Jonathan

