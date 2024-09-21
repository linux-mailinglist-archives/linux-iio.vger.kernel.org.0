Return-Path: <linux-iio+bounces-9691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5320B97DE92
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2024 21:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CA82821F3
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2024 19:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8CF405F7;
	Sat, 21 Sep 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="fJv+aemS"
X-Original-To: linux-iio@vger.kernel.org
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B952868D;
	Sat, 21 Sep 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726947771; cv=none; b=vCjbKTsr19PvPzquRQu9BTPPbWeNxTL23nM+LoUWyRqHvru50ciRqH8ta4hKGwM2r4GzPMSwwkIkIvu+bsOIYy/0U213y1TSueRnlvFryD/pBcfAUzYnw4PjV2i2uoGcFZT6uQn1AGV201/71ZvEU4H+8AAc3gHDEQHtuUQcmHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726947771; c=relaxed/simple;
	bh=WD0l62WRiNQfG0Q3kdKsEWo3rXz5whW3TMxnJU+WH9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgeP2120KJgESouTDkxLoY6jgq6dakjPhc+805W1Xlp0dqwZwtiyzJOuOahmSL5yQnzWHhlA6337ZFR9nH/RjKQNiGbej1IAHSjLr0w9L8S14+qbtL0QvFTwZtCvvlohCjc2O43d5qEHVrua57YLqVMDbVwp/jHeOSULj2zbPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=fJv+aemS; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=gVMI9nzsSsWg4epBZmSVTs+5aw4eeUsG6ABWFEZ34uQ=; b=fJv+aemSaXIGlvyTb1uNxblhjO
	zkmeDUz5oLfdK2QTN6ijOnKd0wGiEpcmDfTzWWT8R3Z0cBlbGxGN0rdnSirH0lsGXXh0US2VdDfbJ
	S7a1EKX8/mKLECAHGYeujs3yXGiHARfKmHiviBQE905wv0PsAsUgzZyPmoP0dbTGP+ZOb2tdlU3xr
	zhDD4gjSpVRb3dqnIwOP88kVORPRNfvdm2mi0Pc3xEFqeYccAkOuMRIGMgdxiwW4bjC+6miZMiiUY
	IZPJo0pBnaz1VyY493tq7SqK29PgXu+Xcce8Ugipu0wRBfMP6GxclKFczajZvFUip+jZ0kj9+GeZ3
	kUn0IArw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <lars@metafoo.de>)
	id 1ss5hm-000Da8-Co; Sat, 21 Sep 2024 21:23:42 +0200
Received: from [136.25.87.181] (helo=[192.168.86.26])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lars@metafoo.de>)
	id 1ss5hm-000PZg-2D;
	Sat, 21 Sep 2024 21:23:42 +0200
Message-ID: <cd1df0c5-d95f-4880-b374-a7544a323d93@metafoo.de>
Date: Sat, 21 Sep 2024 12:23:39 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] iio: core: remove iio_validate_own_trigger()
 function
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
 mazziesaccount@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240921181939.392517-1-vassilisamir@gmail.com>
Content-Language: en-US
From: Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20240921181939.392517-1-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27405/Sat Sep 21 10:31:03 2024)

On 9/21/24 11:19, Vasileios Amoiridis wrote:
> The iio_validate_own_trigger() function was added in this commit [1] but it is
> the same with the below function called iio_trigger_validate_own_device(). The
> bodies of the functions can be found in [2], [3].
>
> [1]: https://lore.kernel.org/all/51cd3e3e74a6addf8d333f4a109fb9c5a11086ee.1683541225.git.mazziesaccount@gmail.com/
> [2]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L732
> [3]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L752

The signature of the two functions are different, the order of the 
parameters is switched. So you can't just swap them out for the 
`validate_trigger` callback since the signature is not compatible. But 
maybe you can update the implementation of one of the functions to 
calling the other function.


