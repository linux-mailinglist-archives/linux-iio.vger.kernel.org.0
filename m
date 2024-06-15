Return-Path: <linux-iio+bounces-6301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D606A909872
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 15:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E679E1C211A1
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C1A482E4;
	Sat, 15 Jun 2024 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5iqrECv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D82A19D8A2;
	Sat, 15 Jun 2024 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457141; cv=none; b=PXewILoyXi74PK9ZSLPYbjSRilBQuikSgiQdSgtsfZqqbZPzrRqxFAFRbpYZ4BcOx9lGbnv0KWH3DWzFK5+QpKeK6BtCcVV1oLQahlCu1IDN+EpFfze3GefQBkM0TNnCBCchp//Eux1rZCtlalFzFu1oJigeQBz3+VP48gUgQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457141; c=relaxed/simple;
	bh=sCaajyoF5wt1RmM5a76ZgBP/wcHHTkocUYQlIPgRzqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDVUx/QX/ibtN1cL5JJt0atD/mC5bJ/AlOMydKbr2OosoNkZ9L34uzf62ZkJv5C0SvakHau7+tPFQtKEakI/fstvBvCCPJ2khtHdNqxy3R62yl83PosCO70a/IosXOQ00e1pdKkCCsyMyhZimx8mQNfxCTxjLBB+uUPWLWKjJSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5iqrECv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F0BC116B1;
	Sat, 15 Jun 2024 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718457141;
	bh=sCaajyoF5wt1RmM5a76ZgBP/wcHHTkocUYQlIPgRzqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G5iqrECvqEiBak/YajBDOg6u7XkU5bhJmgb6xzfZ7zs6gokFtJBiGzTO4/939iaSe
	 cQJJxSvYo6sEc4TzE2uE7IJGUdv8PYb+A/krUrv4dghkjnGVtaoEiBXBO6fq9UwX4h
	 Eli9IssMx73DOKAV1bV6Rn/vbBfoCW9wOTRcgtw4Kp6qOZt1249HYnJX+0RbIKrpJU
	 ww/ZAYb363AKch3dlZcp6YXyni6k9visprkUjuOn8oWZoldL7FakeBEJPCNiyYtYpO
	 jx3TAycD/ePD2vkPPCcawbCY4tHl58vXRDw4pcN35jTdoH4/izL+y7x1UoKyB2cXg9
	 LTdDLFnPA2c+w==
Date: Sat, 15 Jun 2024 14:12:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: iio: Document ad4695 driver
Message-ID: <20240615141215.3579ba8c@jic23-huawei>
In-Reply-To: <20240612-iio-adc-ad4695-v1-3-6a4ed251fc86@baylibre.com>
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
	<20240612-iio-adc-ad4695-v1-3-6a4ed251fc86@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 14:20:42 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The Analog Devices Inc. AD4695 (and similar chips) are complex ADCs that
> will benefit from a detailed driver documentation.
> 
> This documents the current features supported by the driver.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
LGTM.

