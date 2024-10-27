Return-Path: <linux-iio+bounces-11383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4359B1D02
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99A6B20F2F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34882137C37;
	Sun, 27 Oct 2024 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJTaa8Bo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD62AD51;
	Sun, 27 Oct 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730023012; cv=none; b=ME5uth8Mk2b+t8vbH45zsqy7EHJRFpDJ5yd4/x41vA6BuQ1IzeAVLJ2vc6i+7Uk/S49aRKzghfU00WPYcRhSSPZ56KnY5aOcDhqnVb8Ab/femSzBgRXVYTtK+myMzf5yP5IachPUd8qZ2Pj3Ay5gI4lSjddCX4kX7Bm/BzOKzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730023012; c=relaxed/simple;
	bh=5XIZvLX9KPvZPXJX/xCyDWtYHslOzyQuhmfVq6N3pag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncXzq+zOD4oURaHcaebx7yGj2Aid78htQy0b0x63Xqjy5teZUXAWhuGJh2rDeo8hh+1HQh+Pk7D4rej2ZoJbe5HwxJHiOh1sqB0CrSI6WEKBeAQq3NLTgjv8WghPCB3oqxIyOOH5bMT0QpugWz4eUOrR/BagOe8yiPh+ine1H5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJTaa8Bo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6866EC4CEC3;
	Sun, 27 Oct 2024 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730023011;
	bh=5XIZvLX9KPvZPXJX/xCyDWtYHslOzyQuhmfVq6N3pag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GJTaa8Bo5urEj3XjcpVwt1uSX8YmJ4r2gEJLRUoyGIQxa7o8eJAYj/Igbglw0HE8Z
	 vnThmb99de6XM/qJXm0FtqhpiK7dSOiCrt7rxcgRa20K7IztVri1kWC8v0hu9nyROX
	 bXG+oBVnFyg9L8GSvYAIT17m+K4q3QmC6fpQhELJZPr5WrqFoDdL6DYWcxqBPwj6q4
	 zbwlp/550LnyR7O/KMD4cgAO9AT4hzvpK3ov8jNWzia93ctJntfXReHbz4v/I2+Kj0
	 Xc+9nx2MJgQHQrRzg6M2jMW9t3NmX6/cGHxkI983+V6EH8eySYRHkg9hhiqdr+ClkB
	 IFw7865StI3+w==
Date: Sun, 27 Oct 2024 09:56:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/13] iio: chemical: bme680: refactorize set_mode()
 mode
Message-ID: <20241027095641.46d9f0cf@jic23-huawei>
In-Reply-To: <20241021195316.58911-5-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 21:53:07 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Refactorize the set_mode() function to use an external enum that
> describes the possible modes of the BME680 device instead of using
> true/false variables for selecting SLEEPING/FORCED mode.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Improves readability so fair enough.

Applied.

