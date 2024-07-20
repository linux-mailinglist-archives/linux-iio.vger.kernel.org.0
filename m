Return-Path: <linux-iio+bounces-7722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE4A93809E
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 12:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58EFA1F21AA4
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D918003F;
	Sat, 20 Jul 2024 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwXZ7yff"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0729A2;
	Sat, 20 Jul 2024 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721470163; cv=none; b=SNbENPlNhnaeBIWDS1ecOoo7I6VNfHCCLWJ6HSpYwuY5rnZ2Fy/KjaW8xpOamZ14zCnME/XAA6n821dBkUubv/4OETPrGbhEcsNvTAkcRjHzUR7cPA2V0qMa8x+rqWewI8HE1412lPcM9HjKKYDgtBBt6//rVObceRoHQPKpjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721470163; c=relaxed/simple;
	bh=sAULKmqAVYx7J4/hVbwiHSN6cac7mkiWWhe1hts4UEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IR6YqtGACbYpXOth8lwaji62B/MMNee+slOKpB3zvBtrI3Aooh5yVc3Ccrt8A6cZDVhY5iCasx+Y6RQNbA/FLdE2DTsP15RnybuVYMYWxa6/Ll/ifTA4kTW3+9gYk2d8uftkSlPM8bffd/eyWOpgGUFJa/aySv+ru389yWQnXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwXZ7yff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5ADAC2BD10;
	Sat, 20 Jul 2024 10:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721470163;
	bh=sAULKmqAVYx7J4/hVbwiHSN6cac7mkiWWhe1hts4UEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AwXZ7yffSBxcf4FYNRI2KbCd2Hc/9WvkmRrThqdZtHb7Cw2Y2Qy91+elL2G4OWWO6
	 zzNuUDMzdnQD7Es2YTmZca0aQ/avYQ1rSvS6IJdoZm31SlmAp5NVrHR2/LJOHoKc+3
	 u097iXdKXZYTU/H7gDJ7mO0ZrgCIhtIARN1Yd2WKNuqmJnLhnAVhvkJogwGrFhf9rK
	 LQJ01dhXyC1EJDlHyXcV7fkWoEkFrnvcIFOOkMDizimvX/tnhYVjM2o/Y19HS8w5aV
	 2vqEj7JaIaxtxhVL2xVjfJgmua5p0LAmw1pYOMtCfm0YNNhUm8nfCVNFjVpbfcumTA
	 tRg99kbKSI6cA==
Date: Sat, 20 Jul 2024 11:09:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>
Subject: Re: [PATCH v8 0/6] Add driver for LTC2664 and LTC2672
Message-ID: <20240720110913.32409fe2@jic23-huawei>
In-Reply-To: <20240718051834.32270-1-kimseer.paller@analog.com>
References: <20240718051834.32270-1-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 13:18:28 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Generalize the ABI documentation for DAC. The ABI defined for toggle mode
> channels:

Series applied to the testing branch of iio.git. I'll be rebasing that
on rc1 once available at which point it'll go out as togreg and get picked up
by linux-next etc.

