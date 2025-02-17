Return-Path: <linux-iio+bounces-15616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FB7A37B5A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 07:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650B13A8EFA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3295018DB36;
	Mon, 17 Feb 2025 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTplb62L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D91487D5;
	Mon, 17 Feb 2025 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739773774; cv=none; b=JR/p0PvHKCTDLW90o8xDt7+6WFQXfnvrNQQXyZy2hMiC5ctinNZxZ5sdjcSBJjvftZONjqAVv/ZaL7sWoZymAAOMe8xuncQZReBh5W1YaP5nL/idukh8WtL1hR58QxfJeMISsncx55fREb1cKfREra9jHa58wN4Z6kye5hUi7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739773774; c=relaxed/simple;
	bh=XdZq5Ziq11aG3YCD76Vd1zofs0JWom9sk4cDMmcU7KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIKLVKNzDBUW/hf8VnIAWWKIPItF4wPwvsdq0sHYD0uozRKWTyrcQZCUu6YFojGyESBG3oE7otbI1957TicBcqUP/qQUyMGXvOJqj6RlZ141bE9ZuC2qUi5b2tjgcJG+3bwKkb21Hg+MNdjnkdjYRcB3k261HyYjhhyUlhsB+Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTplb62L; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30a2d4b61e4so5651431fa.1;
        Sun, 16 Feb 2025 22:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739773770; x=1740378570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x1hNOOWWhSi22yPi2hiYSqeMnElfD+H2p8Kr9X9dF2Y=;
        b=ZTplb62L+9dKYZ2oZDJK44c2rheofjVffxlGFs92/r9LF1IFB1EftFpdjxWqXfeJzJ
         dTyG8q6hRHaS7hUS2fgzyfrgKL+NRDRug6NF+Jx5sa0in9Nn8L6ipFwZqVGewqFmgDLM
         EjGC0rqXq0BgBwGzeY5gmk0OcsNFHk/54UzKRMaNpEDq4eZ1oVqjdcV7cwr5nt4nwak4
         mzV6mAYE2OfY8H/Pte8b/TcR8f7BLJSFU/m/5vvMUnon4VnC95ydKrzd7a1tl+EktdWa
         ebw0gBwtccsLPV3ejAL9OM1jwDR8k9E3EZYInPvWChVmP2whEpjw03K+GTPgUqWgtgq5
         aDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739773770; x=1740378570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1hNOOWWhSi22yPi2hiYSqeMnElfD+H2p8Kr9X9dF2Y=;
        b=G5ak2ARagH6BosTWeRtQvxA0LKDw5108bsfpSZJen+OjBs3p2ShBIeVCIcBTemoLpT
         7Uzv07MSJ8OnV4fU4UFYKJOkNQ20/u0iTtxxmlFjH1qNrwoFFbFNjBmAa2jQR3ngLeio
         3ML4qFR/NNozuOkWGLsIQ1fbYRrTKc9k5Om6UbXvJFkUm6Gz5V4HQiLt2v9+bmrCyuxO
         XzGVQpGgFys9kb6/XO3xqKZCFjBPoodTKacdo1ZJ9QZMi0wDkHdbAo2WaGhhWS8yirmB
         5d1KzPlOuSDkixTU50unRqZNuJ4AYWC1OSn3bMALLFOpfkaW4waXHxaJZD6TyAkoBZa3
         IO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUC+8qa1uvOROIDriRMWY8gOnINzVnxbHy34rzk54NLkgITXLQzM+M9YwlV0e1C/IFvtOJ749Ktyj2S@vger.kernel.org, AJvYcCX/Fdfq5c1txF+NReCctzpH/yxBWzs1g9AOd0kefXCHiYIrl5DmElammWb2ZOcNIkP9xHJkDr1zQ0vj@vger.kernel.org, AJvYcCXuwpCtdetzlfxb+eiGvhZ/ThKhLVf0UDUKqoyKdRVQXKwnxepVuWguMuJ3NCBkYYfE3jxnxDzbvjWx9NUa@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw7o/rLoAxQ/I+E//ZJE5f3wgJOeAxznbtTW7Mne3z9nauGDsl
	M79fMNcQkdBoeKT64YZdhq/qI/mvN7TR9IPf+CufhiOKtmh9FMbdHlmoHA==
X-Gm-Gg: ASbGnctna/t7VRP1u0bQxFAe0PmfXWRme1L44Yd/+m7L61iixQl2rTnpQEigAuf478D
	Kkh/PnfhOXbJjUlf451J8kHSfRNt8fFx7Pn4mv8tsWuW/nxOFrf4RhqeTogQGff7LJFoii3nrH+
	7brO1ZNO9KwS28Xqx23l7mamEVc7I5e3v6R7a41Oiq16Usyb7B2GzWVXZrzD734a9mFRkBNSsmP
	U2SongpPkqSGR2KzRzWLkUyUMSV1/aAoQOsLsXkrQcMzygTiUKotGCITUDYZr/jQUFq3cJYtgU6
	YxUzNbnaHxvb3+GfT6vYNZ8WS4dF15pFKZ/ehBzMc/7g0/MzTfwza9alH7TNiBk97qlCpbzp
X-Google-Smtp-Source: AGHT+IFQKTGdWtSAsRG8nQIAukWvEvvnDY2qSSWTlS2pz9stc65dYnhOKr8ja4FMF1UEngVoNCQnhw==
X-Received: by 2002:a2e:9853:0:b0:309:277e:8c75 with SMTP id 38308e7fff4ca-30927a471bdmr19560741fa.12.1739773769754;
        Sun, 16 Feb 2025 22:29:29 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309100eaf3csm15726041fa.39.2025.02.16.22.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 22:29:27 -0800 (PST)
Message-ID: <26907711-45af-467b-89c1-8895ae3a7ab8@gmail.com>
Date: Mon, 17 Feb 2025 08:29:25 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: adc: add helpers for parsing ADC nodes
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1738761899.git.mazziesaccount@gmail.com>
 <337895af7418a8e4b20b5a9322344b68082508ae.1738761899.git.mazziesaccount@gmail.com>
 <20250208164111.28ec9f2d@jic23-huawei>
 <ed0e43d8-9ab4-4614-9079-8a592ca8b185@gmail.com>
 <20250211190714.4db240d2@jic23-huawei>
 <dbbeb52c-18f4-415a-b2d4-520dd0184dda@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <dbbeb52c-18f4-415a-b2d4-520dd0184dda@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David!

Thanks for the input!

On 16/02/2025 19:50, David Lechner wrote:
> On 2/11/25 1:07 PM, Jonathan Cameron wrote:
>> On Tue, 11 Feb 2025 10:52:51 +0200
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> Hi Jonathan,
>>>
>>> Thanks for the review and all the comments!
>>>
>>> Just a note that I am currently spending some quality time with
>>> rebuilding the floor of my house. Leaking floor drain can cause a bit of
>>> a work... :rolleyes: So, my time with upstream work is a bit limited -
>>> although writing an occasional bug or two can help one to keep the
>>> balance ;)
>>>
>>> Anyways, my replies and new versions may be slower than usual..
>>>
>>> On 08/02/2025 18:41, Jonathan Cameron wrote:
>>>> On Wed, 5 Feb 2025 15:34:51 +0200
>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>>    
>>>>> There are ADC ICs which may have some of the AIN pins usable for other
>>>>> functions. These ICs may have some of the AIN pins wired so that they
>>>>> should not be used for ADC.
>>>>>
>>>>> (Preferred?) way for marking pins which can be used as ADC inputs is to
>>>>> add corresponding channels@N nodes in the device tree as described in
>>>>> the ADC binding yaml.
>>>>>
>>>>> Add couple of helper functions which can be used to retrieve the channel
>>>>> information from the device node.
>>>>>
>>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>>
>>>>> ---
>>>>> Revision history:
>>>>> RFC v1 => v2:
>>>>>    - New patch
>>>>>
>>>>> I think it might be nice to have helpers for fetching also the other
>>>>> generic (non vendor specific) ADC properties (as listed in the
>>>>> Documentation/devicetree/bindings/iio/adc/adc.yaml) - but as I don't
>>>>> have use for those in BD79124 driver (at least not for now), I don't
>>>>> imnplement them yet. Anyways, this commit creates a place for such
>>>>> helpers.
>>>>
>>>> There is often a mix of vendor specific and not in channel nodes.
>>>> Hence I'm not sure how widely this will be and it is driver
>>>> specific which of the standard things make sense.
>>>
>>> I definitely agree. Still, in my experience, no written standard
>>> standardizes use as well as written helpers ;) More we support parsing
>>> the generic helpers by the (add subsystem here)-core, more the driver
>>> writes will use the generic properties (instead of brewing vendor
>>> specific ones).
>>>
>>>> So before I'd consider a helper like this I'd want to see it alongside
>>>> a bunch of users including some of the complex ones so that we know
>>>> it generalizes well enough.  It doesn't make sense to introduce
>>>> it otherwise - just keep the code in the specific drivers instead.
>>>>
>>>> It's an interesting idea, but not a trivial one :)
>>>
>>> I agree it's not trivial. But I believe adding helpers one-by-one to
>>> cover 'normal' use-cases guide the use of the properties. Those who need
>>> something more exotic can always implement their custom handlers - and
>>> then a reviewer of such handler can ask "why" ;)
>> I'd be fine with a series taking on the task of converting handling of
>> all the documented properties in adc.yaml
>>
>> If we do less than that it may never get wide adoption and we end
>> up with a bit of generic looking infrastructure that isn't generic.
>>
> Having reviewed quite a few patches recently that make use of these
> generic channel properties (and writing one driver myself), I don't
> really see how we could make generic functions for these that would
> be any simpler than calling the fwnode_property functions directly
> other than maybe saving a few arguments.

I started this for the BD79124 - which is very simple ADC. What it 
requires from the devicetree is the channel ID. What needs to be done in 
oreder to get it?

1. Locate the ADC node (device-node)
2. Loop through the sub-nodes and identify subnodes that denote
    channels.
3. Get the channel number (in this case from the reg-property).

I assume this is very usual need for the simple ADC drivers, and none of 
this needs to be hardware specific (when we have simple input channels 
(no need for the differential channel support).

Providing a simple helper doing just this should remove code duplication 
from drivers. Furthermore, this could help standardize the mechanism for 
identifying the channel nodes - in my patch this would require channel 
node to be named channel@<N>. (I see some drivers which don't require 
this but just assume any sub-node is for channel information. This works 
badly with chips which may provide multiple functions and thus I think 
it'd be nice to guide towards naming the nodes to channel@N when possible).

> The "normal" operation for
> these properties usually involves poking some registers on the chip
> (could be immediately or deferred) to configure it. So the only thing
> we could generalize is reading the property value, but not doing
> anything with that information.

Absolutely. I had no intention to do anything hardware specific with 
these helpers. What I'd love to see is IIO-helpers which allowed passing 
device pointer and a pointer to iio_info - and getting the (known by the 
helper) device-tree properties parsed and filled in iio_info.

This sure does not help more complex drivers which require some 'not 
easily parsed' data from the device tree. But for simple drivers like 
the BD79124 this would allow drivers to omit open-coding the loop 
locating the channel nodes and getting the channel data.

Maybe a small improvement but one can't deny it still is an improvement, 
right? :)

Yours,
  -- Matti


