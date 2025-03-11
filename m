Return-Path: <linux-iio+bounces-16739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA3CA5CF05
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 20:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A38E17A8CD
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F40263F45;
	Tue, 11 Mar 2025 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5bAyfUX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB225DD07;
	Tue, 11 Mar 2025 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720245; cv=none; b=ODftxbeqMbFctumhdRHvBsIvFBS/CsAjHA9EnLq2Trh7v6T7pkHatxYYBc1GEEOO+r6gO0jkp3Hfmarc/HWMkhrDhqKpurCP5Kp0FOJvxlQ5YjnDUcNS37R9OxhC5hF9nBEX3LAL4XCFaHVuIMssMSsAHrzWWqa4t0vXx4C8A7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720245; c=relaxed/simple;
	bh=6Te1+MCvDxChGIL5AtvWEAM7Dg1EZcHoZRPgaGsrwfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obCM5LWj4CmIyq8wF/JDCtjhQDr43adgtZJV7sknmZzqO2iEnqyp8tVNeqRH5ET4V+PT2Qk9ry3dpGGuf90UlosfFhy33+5e8NYlfXMMuWilQQMcJswvGBqzG5HK+gRTCQ9pCXrpqW3up7xi82l1kr+JkVoIhxNepjGw7QF/2Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5bAyfUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1EBC4CEE9;
	Tue, 11 Mar 2025 19:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741720244;
	bh=6Te1+MCvDxChGIL5AtvWEAM7Dg1EZcHoZRPgaGsrwfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A5bAyfUXT66apiORTbTCI/dXHJdzgb40oWBL+dqx31VcPjwtjc6KxMoboXnkmtrE5
	 5MlbRYmxGPgYrU+03UVUTcmZZ/mhlqyGK0lwoQQscqrYwAJAzjFf8q/+kz5iuZmjDw
	 eriUcB36I8vp1Mixl5CHsPK3MgOOZvKTF+VTlCWP5T9pfmfkAiJPeCBY6DdO5qjO8B
	 IDBnv96Hy484tiucYsoAv6TnPoDIuw4inEaUzEGkaWckLGqhkFk3YnTMlVDQiInXQi
	 YCg7vIz+OF3Rd3SktnOiM9M96FRDp9yySgZMNpSEoJD92hkejHdiaQAEv3oyBwMXNm
	 MTWIop7FZgaQw==
Date: Tue, 11 Mar 2025 19:10:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, "Rob Herring (Arm)" <robh@kernel.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Ramona Gradinariu
 <ramona.bolboaca13@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Subject: Re: [PATCH v6 0/3] Add support for AD7191
Message-ID: <20250311191033.793d2503@jic23-huawei>
In-Reply-To: <3fa4136e-b384-4c3b-a58d-773887b87552@baylibre.com>
References: <20250228141327.262488-1-alisa.roman@analog.com>
	<3fa4136e-b384-4c3b-a58d-773887b87552@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 16:01:45 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 2/28/25 8:05 AM, Alisa-Dariana Roman wrote:
> >   
> 
> Probably too late...
> 
> Reviewed-by: David Lechner<dlechner@baylibre.com>
> 
Just snuck in (well technically I did push out non rebasing
then noticed this, but unlikely anyone pulled in that 30 seconds :)

Thanks!

Jonathan



