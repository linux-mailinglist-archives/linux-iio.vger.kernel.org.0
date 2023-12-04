Return-Path: <linux-iio+bounces-606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80814803B21
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 18:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFBD0B20A6E
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2D2E636;
	Mon,  4 Dec 2023 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd0/Cdto"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8DE171D9;
	Mon,  4 Dec 2023 17:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45055C433C8;
	Mon,  4 Dec 2023 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701709641;
	bh=mt093VTtGq5Qlwj3G6OkmJBdRwq4g/+zIdsd0yfDcVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hd0/CdtoomeVktSiDKrquMd+1bXGk8Lh0U3TYWfKkoeT7YUk8l2ufEwRmLop522Te
	 QQhUZZNcQ2QcjyrbqOOppuP/r+kTcfIIr4CAaQiHcxAtAOTx/XWFmvTnb8bNlTrJe3
	 3ur1dxl+VqR6ZxNM6HBM7CvXQB7MLmR0yV5Cj4LfQCIFEuQyjPGdrWWl2D52b679id
	 1EOFiP+0RQc3qfLrfJd35tY/0j187QMo8TZ1mV9fs7xvVBXPC/ZLxfZyZnjH+cVtgy
	 oAZ3lUuXLgndjc6Co0437lyD+nbLaRG0WNNfPExMGyzpMCXIA3/bWFr9zkygF0cSPw
	 lu7sL8uq6SEqA==
Date: Mon, 4 Dec 2023 17:07:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] dt-bindings: iio/adc: qcom,spmi: fix up examples
Message-ID: <20231204170712.4d100617@jic23-huawei>
In-Reply-To: <20231204-exclude-tapioca-0db6d01640aa@spud>
References: <20231130171628.12257-1-johan+linaro@kernel.org>
	<20231204132624.03733d50@jic23-huawei>
	<20231204-exclude-tapioca-0db6d01640aa@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 16:25:34 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Dec 04, 2023 at 01:26:24PM +0000, Jonathan Cameron wrote:
> > On Thu, 30 Nov 2023 18:16:22 +0100
> > Johan Hovold <johan+linaro@kernel.org> wrote:
> >   
> > > When reviewing the various SPMI PMIC bindings, I noticed that several
> > > examples were incorrect and misleading and could also use some cleanup.
> > > 
> > > This series addresses the iio/adc ones.  
> > 
> > All look fine to me.  Just waiting for the DT folk to have time to take a look.  
> 
> Yah, they all look grand to me.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.
Applied.  Thanks,

J

