Return-Path: <linux-iio+bounces-11337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F519B17FE
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 14:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0253C1F21F57
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 12:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6845E1D54CD;
	Sat, 26 Oct 2024 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mthH6Alb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE331CEABB;
	Sat, 26 Oct 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945458; cv=none; b=Aedt0DqOtdk9IxKq3xIDDWeGZzXK+a5lgkIcJgJuxONIr+kSv8d/5gVEutJU6zn0nzsC+R32No6PPgp1QMkmkimZbkeJGlWNqhLQ4BlWSQj+6ru4Uq1CbARc+NeOjDiTVS+52xebix1QAULJo3RzBqvps6p5gO5G59RWf4+f3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945458; c=relaxed/simple;
	bh=kO1q2x2TNqovqSKbL+rwFnj9xp9ouk5oRfZzFVn7LN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SG/hjB8ABngO+Icp0GBlLAAI7uC0AxlcfSf08fqXa29ikpw1O9hWTTUMefY1NE/+zUx0CuwbnvbC9ebBaU3tFumsuPyuudZGkDNPUOlmrrhgjPMvsZG1vVR+Alo1tdDfSzAh0GSjuR+bqmumP41MbQw9ktR54J3rXWRKEF66QSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mthH6Alb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8AFC4CEC6;
	Sat, 26 Oct 2024 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729945457;
	bh=kO1q2x2TNqovqSKbL+rwFnj9xp9ouk5oRfZzFVn7LN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mthH6AlbHiPMsUNrjGp6yVtLLDqxtd8g4cIebz1H1zt7h00qm7TpB2D1LtmgNMrMZ
	 D2suiFczBjLaPlDggh2kieOezM8UmOcVHIKjbQa6AMP6fbrvx/r2EBheE3w0GXbH5+
	 lYjaGgvJrvIhXRIwlas+XEySa/kQ7VljFfUnAKSkilUo+PDE54o+StlG7fZhRItVV0
	 /pC5QXdOe0WOZIMIjZbGBAogsg4yulH1HoPWVSAWqQf0+MBl/ldoPRnTwnw0yPY82f
	 dYH3P6b9/+MLE7lLk2KpB12OnJWKy05LUVT6MAJEWE3bvDCgfG/hMxQdT7FdPQWiO+
	 o4hf6pTCUMlcg==
Date: Sat, 26 Oct 2024 13:23:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Dan Robertson <dan@dlrobertson.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Anand Ashok Dumbre
 <anand.ashok.dumbre@xilinx.com>, Michal Simek <michal.simek@amd.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>, Jagath Jog J
 <jagathjog1996@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Subhajit
 Ghosh <subhajit.ghosh@tweaklogic.com>, Kevin Tsai <ktsai@capellamicro.com>,
 Linus Walleij <linus.walleij@linaro.org>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH 3/7] iio: light: ltr501: simplify code in
 write_event_config callback
Message-ID: <20241026132333.2ed8f343@jic23-huawei>
In-Reply-To: <20241024-iio-fix-write-event-config-signature-v1-3-7d29e5a31b00@baylibre.com>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
	<20241024-iio-fix-write-event-config-signature-v1-3-7d29e5a31b00@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 11:11:25 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> iio_ev_state_store is actually using kstrtobool to check user
> input, then gives the converted boolean value to the write_event_config
> callback.
> 
> Remove useless code in write_event_config callback.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Applied.

