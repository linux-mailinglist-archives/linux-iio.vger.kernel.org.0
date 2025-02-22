Return-Path: <linux-iio+bounces-15971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20436A40A49
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC6A17F6F6
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1392C1FF7B0;
	Sat, 22 Feb 2025 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzAezybb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF533D984;
	Sat, 22 Feb 2025 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242984; cv=none; b=hRBXKVcS4B5tj2SABxEE+qMfAuwzt66XJe5dD7D/Ikfkn31l/9gjlLsT2kZDbtRJSDa+h4o//YgT9eXd9FQH+cD3LrkkmtsQr3LPbITLVazE9DEocjzzvfz/tDrXggv6LtJBXnxFixt7EN51pPrL4au3gvBOiyu7JZHA65JUkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242984; c=relaxed/simple;
	bh=nhizLBYVg2p41YJchW0wYIs81W1910Nptu+bsCGqr10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDJQiUy0+8P3zSA99j2qaiTXf0Z3+rX2c1SRIgTx2uUs4fkyVHGIi6hMdPHMrChOktLOYZUsF1D+ywfINhwDrh2ezc7Z+rYkwOlPYBxc4zzQaUEJx6fEO9z2x9Qr5VsEcwzvxQpcTOM4tZ2jXVhccJmM4dJJbnvppZcCIts8QUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzAezybb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37D2C4CED1;
	Sat, 22 Feb 2025 16:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740242984;
	bh=nhizLBYVg2p41YJchW0wYIs81W1910Nptu+bsCGqr10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RzAezybbMIBvgw9tFHVHbXhRjWC3axhgSqw3eWvMZG9xscY16eHQsMnMhALgAp3ON
	 KDHMi0QvbbmtDi24yIFu99r1NWPw6IxWhMEkrkqU17AJEdUH9mICBcJKNPD3DX+/SP
	 1pN4GAHSFWIzXIoy9y4D/QnbrgbeuKcA+e4p5+2/3TzRun/kqqCVzOBf2oXTMlwSxu
	 eABznr1WZGDz0uY6WO1ZE97Yoa4A6UMW53GgR5o8oQ8n/Bo7R5pfC75TzpruaNwDND
	 ZXBgLrI3uI3a2gf7f7rxNdZUoLd0ivjfDaPolzaJSRzUqABWldIUdyzCh8YF6X2x1O
	 ADrDqqkegVjRA==
Date: Sat, 22 Feb 2025 16:49:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/14] iio: backend: add support for sync process
Message-ID: <20250222164937.44bf13b3@jic23-huawei>
In-Reply-To: <20250220135429.8615-3-antoniu.miclaus@analog.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
	<20250220135429.8615-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 15:54:12 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add backend support for enabling/disabling the sync process.
> This setting can be adjusted within the IP cores interfacing devices.

More details needed here as well.  Not obvious what sync we are talking
about and what bitslip might be? I'd guess it's a skid control on the serial
interface but good to have something describing it here.



