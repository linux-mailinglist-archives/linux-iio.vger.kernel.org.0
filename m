Return-Path: <linux-iio+bounces-9330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C0970858
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 17:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5473B1F21B78
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F07172BCC;
	Sun,  8 Sep 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URyrSbkr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63A16631D;
	Sun,  8 Sep 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725808469; cv=none; b=GTwYuMr7f9DPXKcCrz5X5i//44Bqh9IhsBci7kyDBoDLsE3CGtvtdR5XjPBnAzxOyHTNj3WwzlurAZ0W1OPrECeFwRqGbI/qfCmxSlvSLmms/av2al3mHrM5eGyN+scwrdeb7Zynyzt0Djt9/0cHRPI/VEacj5x4M0ktRdAFJg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725808469; c=relaxed/simple;
	bh=zQU4vcZ2UJf8bAIPe1Ymv3vVP4cl047JQd3pT3KhDsk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQIHAnxeflVzHc77wVT9sF2dG1SY8ecDFZ5txS3sytqbI2kuHHxzu+gDeTL6A8y+GLLbR6v7x13jPOw6EkC16Mdy0qfB6iQa+L48el2c6uUyQSyfKIkT3FeUYBHJYHYbhXB2ZHrO0ohL7nBKiPXnqTFlJ7K5Wnu0bMCxs0cPUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URyrSbkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAE3C4CEC3;
	Sun,  8 Sep 2024 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725808468;
	bh=zQU4vcZ2UJf8bAIPe1Ymv3vVP4cl047JQd3pT3KhDsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=URyrSbkr+NsHrbUYFglKnk9xn7o5hHUWj+VoSM3qYkY2EDnglKE99ZY1wn4p6ZR4n
	 WJH+BTJmcRdrOZL9SFVQK9qCFU9AbUaez3ZVa3MQENKMs9V0pJEN1/Wzj29BeMe8CY
	 AUNJH+lNIk5+U0ztPs6fwD0Q4WWLTraElqszWZr+Hboe0vnKoJhetrMUtglPORtH/3
	 Gha9OEoTxPYZ25+9nAtV20oj9woYv3VGsgCDoGL+FwiK031AMrJGtebUK8Uva/h5ax
	 8bIwO/017MvG8Kc7OLXBhOBLlXgYKb/z09p835oDOfeeNZAxEyR0fn1YXKJm19MmaW
	 QHMEc/q3IZCSQ==
Date: Sun, 8 Sep 2024 16:14:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH v2 6/9] iio: dac: ad3552r: changes to use FIELD_PREP
Message-ID: <20240908161420.7af6c090@jic23-huawei>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-6-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-6-87d669674c00@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Sep 2024 17:17:36 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Changes to use FIELD_PREP, so that driver-specific ad3552r_field_prep
> is removed. Variables (arrays) that was used to call ad3552r_field_prep
> are removed too.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

If it isn't too hard I would drag this to the start of the patch set
because I'll happily pick it up as a cleanup before any discussion of later
patches is complete.  That will reduce what people need to look at for
future versions.

Jonathan

