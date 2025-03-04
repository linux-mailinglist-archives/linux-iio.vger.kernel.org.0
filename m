Return-Path: <linux-iio+bounces-16359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B7A4E29C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 16:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11A2188A96E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2002A277026;
	Tue,  4 Mar 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTuwsPTd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC633206F3F;
	Tue,  4 Mar 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100508; cv=none; b=RafbWdZgR6zepumetIQOHkPW6QDDpb9WS22l5GsoszkCPMd0KRNWktkHcE1wSFzAi2CKsLryXa+/Ym36wHR2oLYyC9qcDeRULYFH2SmrdftWg7unHny8/g3B2JaKsciRTeywHuaCHkMHbFGHH+ezOxMwWeV7HgflTIrx3zdrQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100508; c=relaxed/simple;
	bh=0TGSUiUrfOUNocWhd88Frz95OVwI2CI52+kxajp28uc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2R7gHskM54Z7gxWaDP8GnqORRd/QY7X3oJ5uvSWayXiAeajFckC5gSRLOga0ROj8bEunLOyK/df7DHRIhpOJQbEoc5pFPp3euPwNviizKj2tflCvw/dFVgoVmix/XB2ZPR/jTbbxGeblsP24djATiKhFAdGwz08yqjRZCrymNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTuwsPTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9C2C4CEE7;
	Tue,  4 Mar 2025 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741100508;
	bh=0TGSUiUrfOUNocWhd88Frz95OVwI2CI52+kxajp28uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RTuwsPTdAkwrm9FFMwHfyPw2LFKRRoMMx43cYNOhTcUzSJokQVOutNayNYo1WiuVQ
	 hrQfJZ5gIQuQkBDf+iugh+dVMaXgXU8c6iMHcu+PjqlreD4pRPf03o+XN2LoiXo0u+
	 udg5k77CHReM9vHiXPzEulGZ8R9iqu3kCLZ2hSjZK0XVsoeaYrp+Znw8Xn3H+TNu94
	 14xJ1kHMbaJ6D1k5v0iuDV71l2a5y3HFAonXcug6c5Q0jnklmVFj/q7Ot1dto5zg+R
	 Y3Vx8lVVodFqSQ+ApweQYzSJ3nF1291JG9aHnPzKRTZbDChAcDmfwfszywbgtRycv2
	 WeG7PYiXEN73g==
Date: Tue, 4 Mar 2025 15:01:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, Detlev Casanova <detlev.casanova@collabora.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add
 rockchip,rk3562-saradc string
Message-ID: <20250304150135.5ac5bb1c@jic23-huawei>
In-Reply-To: <174077321955.3490993.13046330315407577605.robh@kernel.org>
References: <20250227110343.2342017-1-kever.yang@rock-chips.com>
	<174077321955.3490993.13046330315407577605.robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 14:06:59 -0600
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Thu, 27 Feb 2025 19:03:42 +0800, Kever Yang wrote:
> > Add rockchip,rk3562-saradc compatible string.
> > The saradc on rk3562 is v2 controller, with 10bit width which is different
> > with rk3588.
> > 
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > ---
> > 
> > Changes in v2:
> > - fix dtb check error
> > 
> >  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >   
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 

Hi Kever,
I'm applying patches in a fairly random order today and in this
case I'd already picked up support for the rk3528 so there was a bit
of noise on this. Please check the result in the testing branch of iio.git
on kernel.org.

Thanks,

Jonathan


