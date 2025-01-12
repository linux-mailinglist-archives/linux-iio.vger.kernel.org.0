Return-Path: <linux-iio+bounces-14175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 801B6A0A8D7
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0687A2AF9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211CC1B0422;
	Sun, 12 Jan 2025 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCx6+qYW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0D1ACECA;
	Sun, 12 Jan 2025 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736682903; cv=none; b=LugvnBkQzrly0OZV1+1z+bzgRkBhQhKb0STsZ/SuPdWreJ+Bprd7sN/YeMCg0t6WR6oEmWeVFQjUgieAoHDwBbDVzTjZk5y9oqUrR5XlxYwQVGgz1rlQbk2x0lsPGZWyWXgDuYYdTD1J+V2a54JZW3UxcBLdSIHOGe4Epcnz0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736682903; c=relaxed/simple;
	bh=VmTcEtVKqj4u7husfN+bDDlV9bObcEGnscGrS0K4Rek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQKz1r3LFotKOLvsyL2tXQ5l0JkxYrdgkP7LDV+KH+cTzJlwSIaGPkfJe1v7aCxBJcOo6KjczpMjrJR6SexbfAauTlSDLx9huLLmz+3vSIfjlyuReTEYYe5rPfYkKH9S6dgk9o5aGrlX2bfeQiKs8uCL5RiDlOsMhTSiKMCIR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCx6+qYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7A5C4CEDF;
	Sun, 12 Jan 2025 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736682903;
	bh=VmTcEtVKqj4u7husfN+bDDlV9bObcEGnscGrS0K4Rek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RCx6+qYWwDMGdBwybgB/bJvQztXm93fuO5UbA474YwIUjSi4p9Z0k8mcTgBTNftSm
	 5g8iMuAmSElK6qRQ2orkFhA0CUlfYUv9FQVKEG9TsEzGwEOtzhJrI/tczVGEjjBudp
	 dHGdCjXXQ6azYiBiBWDCa41Onb3yYlk0PkD8Z+Hd9Aa5y9YHe+Tfkj0fEvVgXNFwlN
	 B4jOB8YRfNmlmUSJK7MDjvHQPcSFb+aVAs9903ZWSQgww3htxsEbidjFtWhhlZeGWT
	 HKHGdNAGfsWbLksQgHLNTnNx1cg2yuPuMV5Ai3YRCJT6ksUZqrLbIhZvx1G6FUfix7
	 EZZ1YZHBWb3ew==
Date: Sun, 12 Jan 2025 11:54:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Joshua Felmeden
 <jfelmeden@thegoodpenguin.co.uk>, Sankar Velliangiri <navin@linumiz.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Correct indentation and style in DTS
 example
Message-ID: <20250112115454.4ff5fb2f@jic23-huawei>
In-Reply-To: <20250107125848.226899-1-krzysztof.kozlowski@linaro.org>
References: <20250107125848.226899-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 13:58:47 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Applied and pushed out as testing for 0-day to take a look.

This has probably just missed this cycle :(

Jonathan

