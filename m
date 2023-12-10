Return-Path: <linux-iio+bounces-808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C2680BBFC
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 16:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEC81F20F69
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FDF15AF9;
	Sun, 10 Dec 2023 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="nBiOj3fa"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F35F3
	for <linux-iio@vger.kernel.org>; Sun, 10 Dec 2023 07:29:39 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6273D81EC8;
	Sun, 10 Dec 2023 16:29:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702222176;
	bh=bpWEHI18uE0gDiqkguaJGcxpmC9omDMtU+eO8cuhXPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nBiOj3faGWutOSQWqtwIt5HGgK6QMiqpk7PLoxql7LkvROlEX0lYfRjHgIqeDBzxo
	 rdFzhzK9/xwyXKQQluyqYfq/C9U9b7K7iMMGZTF/P8kC3uqC8vgCpqBjF+vxpjNTd4
	 3H181wRsHViuKy2JbKzavbX7/xryCv8uBnpqRrDod6qQGbRCfoxKljPth8s/+qbo8M
	 oal9rCXya8ubZi+OAkRGL3a90V/wdPwvtUCWdFHOJeC81V8yM0EyA3HMF7ez4Ao4Xh
	 dKkXzxfIupOlDs+mimESvQiz2eyF0UcthnSmGaHziEYPclxg+Zcwb85DH3E8Ll2yuF
	 qucuMyRwLiVjg==
Message-ID: <0340b05f-1601-4f8b-8b38-fa86753f5aa7@denx.de>
Date: Sun, 10 Dec 2023 16:29:35 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: iio: Document intensity scale as poorly defined
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
References: <20231207134200.329174-1-marex@denx.de>
 <20231210115850.63717a3d@jic23-huawei>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231210115850.63717a3d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/10/23 12:58, Jonathan Cameron wrote:
> On Thu,  7 Dec 2023 14:41:50 +0100
> Marek Vasut <marex@denx.de> wrote:
> 
>> Add comment about intensity scale being poorly defined and
>> having no proper units.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> Applied. Thanks for cleaning this up.

Glad I could help. Thanks for your help with it.

