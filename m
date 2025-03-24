Return-Path: <linux-iio+bounces-17215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8143DA6D45F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 07:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28AE16AA42
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 06:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9F118E351;
	Mon, 24 Mar 2025 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfP/qvX8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B836D;
	Mon, 24 Mar 2025 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742798537; cv=none; b=L9rzdp5aofyor5dueQeTFBahV0+uyGtotApPVyaP+E6Z9oZxhkv+AAATyaEIEEBoc8Ammzj2ulTO8z/Al9zkAfn4CDwn/r9TK3RO3T+TsiaMXB6Ciq+ZEWJu5O4sNZcLLEKV/xkUf3S9UfRv54kLU89022Zx9USngBU3P2eCaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742798537; c=relaxed/simple;
	bh=wpPQuQENAU5h+WQlXsjdL+h/wrkk6d7rItqm00Z2Ex0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4XjYUBwy8GxR4AelfPmOPsdbBzPf09Q7EvCErMJyclYMFLfd8MNOW0xDFmnuE8axCijQct+Xh1UFNjhnIps6TDlcFOAv4hcN4lXtAW5YF3z7ED1nD9ogs3slLlppGVSMUSb8SbyX1XPVbiN3OqjXVw+brm6yqK5rlGXm3etfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfP/qvX8; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bf251025aso34629881fa.1;
        Sun, 23 Mar 2025 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742798534; x=1743403334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLfDjx1ynkoqiCrRZGD8BhsHgj6eVyOWE5cQTsG4sGA=;
        b=XfP/qvX8v6+pR1P2ySdyLn37KfO858ylIcqoQrgnvajaBBvuEpRtw19M6JlCj5DsUM
         juZr5gy02w9OcAtfOiVRdrMMTbm328t2asxvHuL7y41m6yCZw0LM2zVEYsGECq1d7lcC
         yEG0tj0nyBA3J3rSLFHDqncYm8+WsVFPsFoFlEHlZ4aZUpYbQLQAiDkJS9NF00dhbkLl
         7uDVxcYbJ5amX2ZOO+KgH6O533rmVyBfoyqIWMblz3PTuIMmzBM8Z0RuuMIKE2oMs5aW
         bPRJFFjo+MC2/ZQVH8Aw7Gqfk8r1UEfKYq7VBzw/W8w7UN4bTYJ+inOOYpo9xMr2+NmH
         d4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742798534; x=1743403334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLfDjx1ynkoqiCrRZGD8BhsHgj6eVyOWE5cQTsG4sGA=;
        b=K9M8WVnE4zJbTl7wu0eluztnJ4qVd8gFOwz2t6t/DRSFX9Bh/NOT/4mEXG0dH0TeOq
         jqRxQe3rrwdX1pGy3dXC3HEdRmx4TeDVlKUzQYBEtQaNRLqFcX1n+tX1yF7PGrnaAdiv
         kq4bZl8sXhcL41t68nLypWxfFvFn0Kp9LcT5qL4MlJIhn7bDN152aPKWSETZ1xCMDsuT
         NxAoPIFk2JtIfN2klcEscoBn393G/JQK13/dnw5qjQDMR3VmOXso+8b1eA8eA9mflIUJ
         QE7wBV7A7B09hLGhgCMvThG0xUMKCDV5gnhr6+t5oHAfmHuF6tbXBFx5SYk0K0o8QYEQ
         VGrg==
X-Forwarded-Encrypted: i=1; AJvYcCWjqKKPCVcIHEL9U3xQCpDIKDqu2V2Ypc/hC1ulEZpV6HNgIEZhq8RHg331DLz8a0OjLKTWemHOSq8=@vger.kernel.org, AJvYcCXjkQsQ8bRJt+K+37hsEuWY4lsL5GwEsHjqaDJLI0L5LsI38qEY3I5Uvf+aKXLsU0WRTtSQ3Z+Jpw+0QfNg@vger.kernel.org
X-Gm-Message-State: AOJu0YwVE2Jp7alGSzs1yr9u170RyjqbBfPdM/IoZVjikcLCzXDWIWXd
	WjESf4XhVc6QnwK6VYE75Ql50LQr59IFoHqBOYgKzZno6EbGnQdj
X-Gm-Gg: ASbGncs3KoGmz02V0EUGuLbIoO+mBXEmYRo8Cj7i+D4gc3YoK5rIYzphE31tlZGL1RM
	QfYMU94PJJkLwBF/ht+svz1JMnyYiiHC7hUziF38tYBpSqdxIE0ZvsLXLxyRCjoqOi3+3QGru+4
	tqn3SgRt73xGMOE8o9gIxWEudYYH+ETPSBLGK5/ePQlnW3EUywpO8txCucYwnVDVYNPtO1ImqCE
	AAakAqkRFnHR+KWHP6Etof0TDORMCQLDHPu3sdpezxAOruCzbKpq5hHVmVuRa8xp6xeJ0i1hHT/
	cfuhP6p4XFzbpVe42w2fDPaYMrNn4Jwik14P0Fa2DYWQo6Afc7E7HWTca3I1amPtd8xINfpVtAY
	liAo31fhLJ42+RaZsweCOBEhcDw==
X-Google-Smtp-Source: AGHT+IHRW8zfH5Yj6aLiPkaPDVFiDX9NW1JE49OSKvR3WWTMq5q9opGWt0ulG5T6cuSROc15weA2tw==
X-Received: by 2002:a05:6512:3d21:b0:542:28b4:23ad with SMTP id 2adb3069b0e04-54ad6489f85mr3796146e87.16.1742798533283;
        Sun, 23 Mar 2025 23:42:13 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6512515sm1028090e87.247.2025.03.23.23.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 23:42:11 -0700 (PDT)
Message-ID: <02d42b49-26a9-47d3-bf56-800332d8a28b@gmail.com>
Date: Mon, 24 Mar 2025 08:42:09 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] iio: adc: Support ROHM BD79124 ADC
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1742457420.git.mazziesaccount@gmail.com>
 <544371135e5ff5647c3cd4bce6d21e1b278ac183.1742457420.git.mazziesaccount@gmail.com>
 <Z9wVQ8vgV8kQylqG@smile.fi.intel.com>
 <ae33de64-1ba1-4bd2-a139-3f0b5986f41e@gmail.com>
 <Z91WS-DoKoIZhRNs@smile.fi.intel.com>
 <1e236993-47fc-45e9-913a-e0615787581a@gmail.com>
 <Z91mnHP9V0yRZ2js@smile.fi.intel.com>
 <ed5bc103-1ce2-46ec-9649-03b11ae591a7@gmail.com>
 <Z91wCjTb14wCbKmj@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z91wCjTb14wCbKmj@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/03/2025 15:56, Andy Shevchenko wrote:
> On Fri, Mar 21, 2025 at 03:41:18PM +0200, Matti Vaittinen wrote:
>> On 21/03/2025 15:16, Andy Shevchenko wrote:
>>> On Fri, Mar 21, 2025 at 02:17:16PM +0200, Matti Vaittinen wrote:
>>>> On 21/03/2025 14:06, Andy Shevchenko wrote:
>>>>> On Fri, Mar 21, 2025 at 10:01:00AM +0200, Matti Vaittinen wrote:
>>>>>> On 20/03/2025 15:16, Andy Shevchenko wrote:
>>>>>>> On Thu, Mar 20, 2025 at 10:22:00AM +0200, Matti Vaittinen wrote:
>>>>>
>>>>> You can get rid of all of these by simply using __le16. I do not understand why
>>>>> it's not used so far. I thought that bits are mirrored, that may explain the
>>>>> case, but now I do not see any problem to use __le16 directly.
>>>>
>>>> This discussion is going in circles now. That was discussed in the RFC
>>>> review with Jonathan, which I did also tell to you during the v7 review:
>>>
>>> Yes, because I think we all were confused by the bits representations,
>>> but now I see it clearly and I do not understand why should we go the way
>>> you suggested as it makes things a bit tangled in my opinion.
>>>
>>> Jonathan, do you still think the two separate bytes are better than __le16?
>>> If so, what are the pros of this solution?
>>
>> I don't think Jonathan thought this is better. I'm not sure if you read the
>> RFC conversation.
>>
>> I told this is easier for me to understand. Jonathan merely told he can live
>> with that. For this particular driver it matters because I'm expecting to be
>> maintaining it. It's easier to maintain code which one can understand, and
>> if subsystem maintainer can live with it, then I suppose it's the pro you
>> are looking for.
> 
> What if the maintainer will be hit by a bus? The point is we should also think
> for unfamiliar possible maintainers and strange readers.

It's not like I was suggesting something totally cryptic. And what comes 
to potential new maintainers ... A bird in the hand is worth two in the 
bush.

Yours,
	-- Matti

