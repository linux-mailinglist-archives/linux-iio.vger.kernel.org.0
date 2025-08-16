Return-Path: <linux-iio+bounces-22825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C598AB28E34
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8457B53E8
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741E4285066;
	Sat, 16 Aug 2025 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhnUelq3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F82E7188
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755351695; cv=none; b=o6kiIUjTXePgiNcx9BruCDlD8Kz4I/y29aW1F80ppfXm9fQJjtXLI0GuYPcREjvFQmk0dLfYOLJ1pVPaBf/z5DjaWX/htwqIFBUYxizXW1/4hLcJbMErSdRfDG2PQVJxnhWg2pFHUN4a/j+fV3W3tB614epaN+mb3kdR3WRgPQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755351695; c=relaxed/simple;
	bh=BIsCWnKYgsaMfhTdlaJrNnS9XERcfX8qP+Q1rbQbMho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j20sreXAaj5UzNCdAUsABB9J8w44KQLK5bt1sOE/Jw+j+4+UyyL7wik22RyXXgv7EjJz2bX6JK3x0X7cguzNhGltHDKmq0YuV1dsRyxuChI0UxhNNRiRoRD+JAOq++ONnVHZFi0kANKE9iOL846dmcPLCTQhYyIgElEtDaf3MaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhnUelq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271F1C4CEEF;
	Sat, 16 Aug 2025 13:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755351694;
	bh=BIsCWnKYgsaMfhTdlaJrNnS9XERcfX8qP+Q1rbQbMho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LhnUelq3R6Lwo3ALPzi0KM7WMqzuMSRiujERdAaQ9mE16jCEjuEFFKoi6mZarWY87
	 fVPsfMmTE0UsH+exXs/Y2c2fs31ejqpSaT3GHJppQfl/0cn7bOGMW23YYqhCpL6GcC
	 +dRrsbIgc+By7+lHh98UG0rEwe7dAfOKZNkhVpIOpgtIzomyOCdwkXgRTIGsOxW42F
	 2K5H8hQvvVby2OkxMp9xcTuaC/+pJHaOoDUELQc3UhV2utGe8rhdhGbv9QFS0hFiYv
	 pJd9NH4htsPIqHgpcxWzPaKwoFvfwsMZe3tm+HJtEmXr6HmSwJZEUyqtKAfjNgV7ds
	 +AymxbHGDclzQ==
Date: Sat, 16 Aug 2025 14:41:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Matteo Martelli <matteomartelli3@gmail.com>, Liam Beguin
 <liambeguin@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 5/6] iio: test: Add kunit tests for
 iio_multiply_value()
Message-ID: <20250816144126.1665e01e@jic23-huawei>
In-Reply-To: <20250811155453.31525-6-hansg@kernel.org>
References: <20250811155453.31525-1-hansg@kernel.org>
	<20250811155453.31525-6-hansg@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 17:54:52 +0200
Hans de Goede <hansg@kernel.org> wrote:

> Add kunit tests for iio_multiply_value().
> 
> Signed-off-by: Hans de Goede <hansg@kernel.org>
Very nice!

I don't have any comments to add to those of other reviewers for
any of the series.


