Return-Path: <linux-iio+bounces-16700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F01BA5A4D2
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE915174E20
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1D21E22FD;
	Mon, 10 Mar 2025 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drS22X/D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5911E0E15;
	Mon, 10 Mar 2025 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638013; cv=none; b=GZ1wUwivqcAPCtWkKEKXfTt+913J4UH0F+5GiJvfexuTI/6tez3/UCuC8fQAY1fSAq1AHQv0gI8888cWyi982rqCbPT9aekGo5TWrzR4qnaqDxfudBPfWHmKB+Oov8y5HBV0feNdTcQfcfccfpMD3C4EMQEbyC4tmZ8y56eNkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638013; c=relaxed/simple;
	bh=oiEDLHboG9k635mQYmv0sZ1NLB6XV+uB6u93veYOWYE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAv3Bp6zNScH3n1Jzh6YKE/EwwpVbWHi6AqG2goGY+gEyrHCxeJt0n2n/nfNTZw44waEku7NR+2psozfkpKArVpFMx0+UXq72S9thP+R3nYzaOGPhDza1aGf+7dGk9dqiYk6XEUKrscwxnh/Wkz/wQl8xO1cOjkeawF1UxxgrWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drS22X/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39574C4CEE5;
	Mon, 10 Mar 2025 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638012;
	bh=oiEDLHboG9k635mQYmv0sZ1NLB6XV+uB6u93veYOWYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=drS22X/DU2o4gwHxWv8swD6uzt8Rv2KL+qVhojMrOAIjTnOlTaMJoMJDbPypfm5Ct
	 thXU0VWdopO/P87hoVr6Rnc9DcO4GemvFktUBpF+Cwecq+mUb4pbZvZEmQ59E/4Ssy
	 izSA9FTPrSSe2Lq4AsAOhgQNi1rruiVY0f4oHGu/iw3CGz9Hdg2qcp9J+BxLFcJIzi
	 2YonFBSAECntGQdSG8fToTqLa0KzOg5viGhOBPVfhtwUWgSiIPBf0X6ZRmcFibaFts
	 k17dwgbPrvowiKrCQV9OPiaeMwFAcnKKmXbHj/NR5aGvnbf/DkHv5DqG3YluC2CZ8E
	 1Dx5XD5nHXsRg==
Date: Mon, 10 Mar 2025 20:19:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Scally <djrscally@gmail.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v6 02/10] property: Add functions to iterate named child
Message-ID: <20250310201959.39bad5e1@jic23-huawei>
In-Reply-To: <Z872bHMRtSglB8pf@smile.fi.intel.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
	<ff924f640feeb87819d40557f12a04e607894682.1741610847.git.mazziesaccount@gmail.com>
	<Z872bHMRtSglB8pf@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> > +			if (!fwnode_name_eq(child, name)) { } else  
> 
> Ditto.
> 
> Note, I believe this won't get v6.15-rc1, so there will be for_each_if()
> available and these will become

Unless this cycle goes long (i.e. an rc8) very unlikely I'll sneak
the series in now due to lack of time to soak in next.

> 
> #define fwnode_for_each_named_child_node(fwnode, child, name)	\
> 	fwnode_for_each_child_node(fwnode, child)		\
> 		for_each_if(fwnode_name_eq(child, name))
> 
> and so on...

Nice - first time I've seen this :)

Jonathan

