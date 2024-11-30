Return-Path: <linux-iio+bounces-12848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912BB9DEFDD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 11:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A4D281655
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 10:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEE0156225;
	Sat, 30 Nov 2024 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LRkLS2ZW"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC04087C;
	Sat, 30 Nov 2024 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732961385; cv=none; b=fOBi3Kj6MyxrXX7tGcelRxdKcAGKXPTL8/VejlWu/kKEw/XbWDIMtJFOgf3U0/eS2rDtQEvrms7Dxk9sQXCNci2w0SguSCfKCnUexVDIyjORu9aUmzAmISKoRC9/smD92pQlVzmv+77OrEB8XIIDlIApdhgOrII+/B9ny+GLQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732961385; c=relaxed/simple;
	bh=uOiGLwvkvgoYoKv0QnGSMigngzpPHVBysTyZdrEIX6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW1gaHF+TucbtM9c+6YmvGMBvDUgPYgAT28qBJvJKwm3eOp57AuA7K4Gw1rKqPiHYvib6XJzb8C0kOzqkTJwTbwfYOVhhQqA94sWVfoRqvKz5arTvdTLhlWkXsBA/gQ2OXR1WCvASGuO6ya5AYVU1aVHy6pgW2UJ3maS0Cv3r/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LRkLS2ZW; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=anpPqZ9rVCBNoVnKGwwdxppFy/WZWL2ek5ZsnhX4RRg=; b=LRkLS2
	ZWQ0uu2swbqlRLoDGTnhX56HZOPj1p2H1VmQleCIdrUl7g2dlwK92pGn9UtNrJjxwGWAwdFsmeQNC
	zJe3Inwc4xEVTzUjq++0oSSZngeiPanuTimQ82HJVGId2ABnZdIVzM72ZBji9vO4wBMCQE33IeWVm
	bZGYLMDqlUG5juk/trmJXxF4oMgee9QFiQZCHgtVuecBtDNcXOKqem8swAIB/g8Y50U86Z++ihcq7
	+emzm6s8GA7fM3iiP2s9o//rAv0/3ktEvVlL3fOjsLH7AzV1/Oe3bG3/sOSCU7zETc9uD/hMy5Cxe
	K03YqfFS4guZBivhjRtFddX+JISA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tHKPz-000AXg-Ml; Sat, 30 Nov 2024 11:09:39 +0100
Received: from [2a06:4004:10df:0:91b7:d12e:d581:184a] (helo=Seans-MBP.snzone.dk)
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tHKPz-000DLt-0e;
	Sat, 30 Nov 2024 11:09:39 +0100
Date: Sat, 30 Nov 2024 11:09:38 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: fxls8962af: add wakeup-source
 property
Message-ID: <3tbd7iku2uvogozd4nuqrdvsyxcuvjfsqia6d4uk7httcocfxl@hqgsarodnrct>
References: <20241129-fxlsdt-v1-1-ff7697a47cca@geanix.com>
 <k4udl2se7swwlqcq763bwydifkfwdzwem2crwroo2ohmv5j33o@zr25gt2r2x6h>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <k4udl2se7swwlqcq763bwydifkfwdzwem2crwroo2ohmv5j33o@zr25gt2r2x6h>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27472/Fri Nov 29 10:38:16 2024)

Thanks Krzysztof

On Sat, Nov 30, 2024 at 10:56:06AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Nov 29, 2024 at 04:01:24PM +0100, Sean Nyekjaer wrote:
> > Add the wakeup-source to enable this device as a wakeup source if
> > defined in DT.
> 
> That's a circular argument. Especially last part "if ...".
> 
> Explain the hardware aspects / reasoning.

Is something like this better?

    Add a wakeup-source property to the binding to describe whether the
    wakeup interrupts from the accelerometer can wake the system from
    suspend.

/Sean

