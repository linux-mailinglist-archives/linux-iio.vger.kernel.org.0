Return-Path: <linux-iio+bounces-20088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D646AC9C19
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 19:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A72B175381
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02AC19ABD1;
	Sat, 31 May 2025 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJkaYG3k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3683B19A;
	Sat, 31 May 2025 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748713450; cv=none; b=gplDpybsTfrnuSyCRY/9ldRlBz9daSMKZMY2Hhk5vNfAElgWS5F/3oYC/hQyEa4mRjVme0mfN3rGbw5kWKLkyyqz3NaRp3ub3m7Bz7gEXsOrYHvZ9St5wzDiVIfsY9RPIAtJHe2CNmKcubm5BdxOtai8K0RQ4g/htFYCXr0vIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748713450; c=relaxed/simple;
	bh=KC9jA8H6pw4xmOntDgmQriU+FOali29eerNw8ZrueTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tz73x+rjLvor+204hyKlNJ3BbkIJ3raEft3vMPWCllc3oc6Jmt1q/0ZkKo8XKlvAfGmV4AHWgIE8ZDhwnrbxAqoMbCM+bKfCpCTJCIk+6k588FJZOU3WiDaNUGI2oIGUh+FjD3UogqbAK4pq529MqU0NCffS7MWY43K6IlQHJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJkaYG3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD66C4CEE3;
	Sat, 31 May 2025 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748713450;
	bh=KC9jA8H6pw4xmOntDgmQriU+FOali29eerNw8ZrueTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DJkaYG3kfIrGX/51HLUKbnjounNPT6yudtEKzVFylbcRa2Fl6ObjuQykMzY3zhGzQ
	 HivxyzCFxaIiHzfNzB8d/c0Di5E740awtQgJWNv4jSBsZANSt8uwQQDN7jov+sf0rc
	 Fs9+mhSQxbIsLvXAh9kRa3F9ehr0wSrBcPp0dWOeIFZDMnHUcRKXFaqrm+LMBEQtuq
	 3bLoxiqJ/e8RcJk5Zmz2kcg+kAkSrnfe0aEeZQ5GxM599A/OOiy6Jvz4y3jHebK/U+
	 rWkOxc05fka53tA6JCFMsYJ3BL6F9uEclPUceBbRLDquLtue1tE+iA2NprYNcEqqz0
	 sBnDIjyUfYnXg==
Date: Sat, 31 May 2025 18:43:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com,
 rafael@kernel.org, djrscally@gmail.com
Subject: Re: [PATCH v9 01/12] device property: add
 fwnode_find_reference_args()
Message-ID: <20250531184359.370d4629@jic23-huawei>
In-Reply-To: <aDnvXkwDSh_RCd7K@smile.fi.intel.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
	<55924e747e4891ae75288343d9f3ad2361174bd2.1748447035.git.Jonathan.Santos@analog.com>
	<aDnvXkwDSh_RCd7K@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 20:48:14 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Thu, May 29, 2025 at 07:48:17PM -0300, Jonathan Santos wrote:
> > Similarly to fwnode_find_reference(), find and return a named reference
> > to a fwnode handle, including its arguments. This wrapper facilitates
> > cleanup handling and improves readability.  
> 
> In principle I'm okay with the code, but I probably missed how this new API is
> being used (in terms of a need of those arguments to be retrieved).
> 

Good point - this needs a little more justification, particularly with respect
to why we are using it in this driver.

J

