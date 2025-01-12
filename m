Return-Path: <linux-iio+bounces-14207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BA6A0A985
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BC13A17E6
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB911B4254;
	Sun, 12 Jan 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSkREVN7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24915278E;
	Sun, 12 Jan 2025 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688149; cv=none; b=JavcIerGWJOUwFKimzC/Qg+Eef13g9AyrdP7bIMOYCZBjPX4cRO2kro1NT80C5czu68/1DlA1L+S9rOvEUYV3BYM575qvQj2badm55/YKdegA1YuiLqxHLzw4If8XbYGRM9EmkFQgdx51Vm6eVv2naXhIn+HOy9EbHi7XX3RvsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688149; c=relaxed/simple;
	bh=VeOwc3dw6Sh9zY8TAw1nwR/5+k/71wp2kV0z3cD1Dn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvBjqplVmZblAto9lUL/6QhZXR966+98YA6HzE86piP3kJb7GJg5kI42LOzKRqfbinhaAs4tK8ZYmI9NESJM2+WumaFEiB/dTdoOFudXVSXATPFNsduWIRQBf1AzK0BtRcGd68XdfzcrrvLhul+EKm/zOqTJC5EVmH+1JcK/RZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSkREVN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F76CC4CEDF;
	Sun, 12 Jan 2025 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736688147;
	bh=VeOwc3dw6Sh9zY8TAw1nwR/5+k/71wp2kV0z3cD1Dn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oSkREVN7k+afLjnopbjNmz1XnfHJ6qFe8dc/aYJeoxD9p2eeCq9MWVQtMt+U2xHiJ
	 K2jeRyda0/t4Rr9TOvHTAcg+poBKXTHmo+QIGXP3P7qXWIGJodgR6KEqzp3FnfAXEY
	 Wu5kAYCVb0mxVddTW/6VyOBcfYdHfYmCrYTc3Xczf8+aOUSIv2mye1VF2SdmbNsJ2A
	 oepHpDbY6OhhwRBI/xiGhgu+I+PN3nEtg/BWafw/eKIxajCNICc9VEKsOg9pvHLD6f
	 u7QFKXEWw9l9wTwn5KsM3jN2Qrg/2mUnF0lFefJ8si/14mWiuhFfYQLBqhUyn2VuXT
	 2eGmwg3MiA5sg==
Date: Sun, 12 Jan 2025 13:22:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/2] iio: light: veml6030: fix scale to conform to ABI
Message-ID: <20250112132219.7b0eb004@jic23-huawei>
In-Reply-To: <20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com>
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
	<20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Jan 2025 21:50:22 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The current scale is not ABI-compliant as it is just the sensor gain
> instead of the value that acts as a multiplier to be applied to the raw
> value (there is no offset).
> 
> Use the iio-gts helpers to obtain the proper scale values according to
> the gain and integration time to match the resolution tables from the
> datasheet and drop dedicated variables to store the current values of
> the integration time, gain and resolution. When at it, use 'scale'
> instead of 'gain' consistently for the get/set functions to avoid
> misunderstandings.
> 
> Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

For iio-gts useage please +CC Matti.

Matti is far more likely to spot subtle issues around that than other
reviewers such as me :)  Obviously that depends on Matti having time!

To me this looks fine

Jonathan

