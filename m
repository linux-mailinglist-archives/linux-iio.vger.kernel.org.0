Return-Path: <linux-iio+bounces-18021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C8A86E79
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 19:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36912189DDC1
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFA0203716;
	Sat, 12 Apr 2025 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITHxGCC+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88C1F4E34;
	Sat, 12 Apr 2025 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744480328; cv=none; b=cmSc3N6fPkoosYAmXoI+zY7PsLnxAutP100t6e/hU+jGNS2D8DljzcTfi85xoDzdCv/znHTRcICjaxXpniJnWuj5IOPGiZh1P0hyCQIGSsAc5l3fkR6yskKT6iC1iU2EsFi01p9Q5w7V+9wS/37+RJtjRTESqZencKWik2rxSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744480328; c=relaxed/simple;
	bh=ZSemBqNWvxfXf7wozXPgFrv4J+FrxqsyyJvFkrck0zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvlK8aV3vEAM8XyAKRGcYWP5IIAEbXUZNnYQcWIZhfdSGzxWdGIYu0tsEumpWYu5XYtUWMNjcwetYATsYvJWjZh9RnI/DEGS1Y06G4R+9c4lwnClb09XWj3MRC3Xtq1n3c97jjtnoe1Q0cLZ9FpCBSWSqu7JCGisYRZVcxsxA2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITHxGCC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89DAC4CEE3;
	Sat, 12 Apr 2025 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744480328;
	bh=ZSemBqNWvxfXf7wozXPgFrv4J+FrxqsyyJvFkrck0zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ITHxGCC+GRpClt8k59wiSW3ZuAI9ON8Dq6DYIPrvmYiFdo8me+kN7pmI+tCoK5D7G
	 EdfhEtU6xRQJbxf+MtM382wYcLtXvHyyykqbWHUy/dYwnUPim7NtaUimUHYitSfush
	 ARLLGvLhVal3mTJg3dZjZe4OkGnZzcSpwGK8T3sLV+Zqdy+cQjjM/b64qSkovpY2C9
	 WlqkcRCaJyLHNLGo5TMq98+aRyvYmkmlSox+tVAiHPdiyShsj6ZnSvxNSOrkkXHK4j
	 4Dnvn2HsqFTw/ChTRoVFcuF4Z6U4acXZm9LfVEPK/OXIYkAAZSBhIFQupkKnTdO7UI
	 1tGPZfWBCk1bQ==
Date: Sat, 12 Apr 2025 18:51:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: Re: [PATCH v5 05/14] iio: adc: ad7768-1: convert driver to use
 regmap
Message-ID: <20250412185158.5d47e918@jic23-huawei>
In-Reply-To: <aec9e5452c1ac16d5379a80dfce97c00d85614a2.1744325346.git.Jonathan.Santos@analog.com>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
	<aec9e5452c1ac16d5379a80dfce97c00d85614a2.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 12:56:56 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Convert the AD7768-1 driver to use the regmap API for register
> access. This change simplifies and standardizes register interactions,
> reducing code duplication and improving maintainability.
> 
> Create two regmap configurations, one for 8-bit register values and
> other for 24-bit register values.
> 
> Since we are using regmap now, define the remaining registers from 0x32
> to 0x34.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Hi Jonathan,

Given this is a fairly substantial set and some parts stand on their
own, I'm going to pick up some patches now despite discussion being
ongoing about bindings etc.  Please rebase your next version
on the testing branch of iio.git to take this into account.


Applied this patch.

Thanks,

Jonathan

