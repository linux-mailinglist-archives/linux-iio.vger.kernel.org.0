Return-Path: <linux-iio+bounces-16654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FD1A58D1A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 08:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7163AB13C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CAA221F08;
	Mon, 10 Mar 2025 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7IaUz1p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A1221DB2;
	Mon, 10 Mar 2025 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592467; cv=none; b=PCYL7xTw4Kgm4OAPkVuJBq/yn8mUx8kaBW3W34LC2gqlR6dgc2RHVj3idV1UYT3PqWbLqx3e+pk55pFBIOU5h3BALZeHJTam146NQ5eREAS3k3Y6YXr9gIRw0e5IQRJI1Fkbt7TPUZgsrOOh/v18uDYi3LBm4By3yxtRTy81AYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592467; c=relaxed/simple;
	bh=LTMAUQTizHw74W2gOqhgX2l8ap8D2eBxC8RTz2GImYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PClRoOW/nXoiGIjDXaw2QHVsEJA7wLCgiiGaCKz5W2c4FW0g9R+rDoJ04+qHlrL44D15m5cA46/ttVDMYRLgh+xbvLvTXi5rKlu8GuMA5RmlsyQEZlSia0JpM4mRbz4p0qEn0J/p5r+TqK0CC5nAHNBFDaoVRZhFmHWFAeAt2/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7IaUz1p; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-548430564d9so4166672e87.2;
        Mon, 10 Mar 2025 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741592463; x=1742197263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osEFHHA8j9TYONQ8F8JDSlqbUbM3s6nOsIv91QRD3Lc=;
        b=M7IaUz1pL/Fkht9c6+DMpzfo3RJiMc5fJOAhhWo0OZDmcEPTSlg6fmqbUsO76aGVct
         YM6qc64fBtyLPw05f5YOodRcMcpUNx4BLpGE8liHaoQxz4YJkNcNWvkARMJJuTdFrSpA
         mp46zF2SmNoLsSWP1fwYKacoVd2VWpFMjo7Wxok9Qgh/Df9UesUoJq7DaVm1oyBiKRTG
         rmvGV9I21X7NM8Zfbz7xmaPxjL8qWcFnXz+2j1m1FZhsurO5tIPYeu86OHkhjOifUWyd
         xee34B96JD9ZD9x/lPd+i3cVSPIKWtvcjhtyskijsL7zlT+Q1aIhcVN2c3GtOBJmQ0Oh
         0CbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741592463; x=1742197263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osEFHHA8j9TYONQ8F8JDSlqbUbM3s6nOsIv91QRD3Lc=;
        b=a/Nsbh9qeXpLi8nUfDLG1o+KgQJUnC9oQ6/nh8ZJvHqtqGGwY2a4q1gu7TcdguFVEi
         KThi1jEo0ym375A/0oghAZd2u5bCZYKdo40Ak4XTwFcAQupTDMBUK/L5hHRM82+UURnM
         qY3kRR1DmVZdLrCsudM2L43Ll7LRFib0Kvw31PcpXVXmXR1xKANMDgNYocyHtG2czReO
         uL2styeChDCdQBcqXnTI7z/rpuIBfY1GVZ6UT7qWEZp57NvBh+aE/0y30YL0ZruY3gMN
         k6ZovkbPnYFQ4KEPnCmKwHCRsDVWaqPBsTZdOVy5rcJ66geDSOP/cimUi8vvnLnPUohu
         Ehcg==
X-Forwarded-Encrypted: i=1; AJvYcCUqnaIucHYEaeGL8f7eRwxH+4D3xYIiYfrys1xkrgVBaWurs/1q9nP9+edHytEDz+2/IeiSCKgVNvSVX2Mk1CtvjX0=@vger.kernel.org, AJvYcCVFl8sgPMv5K6ZgSh+XbvFjcrqmSeGMpSNt19l4gHITQhNCMhWbub3D82zoku4U6pMzWsLAZDiQZBQH@vger.kernel.org, AJvYcCVJyXk+todzfmqmwvUslvM2OqolRuhhhlJEkXt25FxqXUo/sCpCZRuOPWRqrjkSuRGWZuhoCxvA90sm@vger.kernel.org, AJvYcCVRp1KuIcsRN0D0KSOnxM53ae5TfLLSsHmFscDAg//VOHuZ+1YH3BOHoi44elDk/AYipKRsFdUEUQZZww==@vger.kernel.org, AJvYcCWNQdt6SSt4jnh6FrOa8canLANIbwJATzWR7Y0t0mwpSF3hgL1aMTXPLX7VCozmzQR0htC73Qpi67fMqXyT@vger.kernel.org
X-Gm-Message-State: AOJu0YxFxZquo8PKroukFc11TWZ/a/Hd13QWnC0DWghz2BoSB3rRtDyu
	ZozBbJT0lR7zbTsZzIelx0pJDgjszQcRTNnC+sKSZxeQnMojCXEonI0O0g==
X-Gm-Gg: ASbGncspsYtURzFPa2hf/9KDoH/ttcyc1f2XBeJRkgIFrBZYjgikGQfTBLoHCXq5VCh
	/SD2mjj+YZukn7PlcgDQkNsyJV7lWGuEvxOoYOuKPCfwXZim4U783wiYSkXqIbVhBC2AD6LK+D8
	osoNtdATeoB5soqGSmvSPOBpFzWg1mOsm/M0T6hwXuVAEpEBJLIF9TO13dR1Zm6CsO44BMeEhyS
	THcdL5xU3HbNOtOwQrsv9FOAJeRJCF6VKsgeSrSqgw0t75asab/qs3N7h2TXlc+95NqyevE4IH4
	Znz7vJ7WlWp8Ps5N0HRjplq04/Unk8tL98CC6aiCVhpE/pPR6d9kk+tyO0HFf8H05H1hE5JWVYM
	KWVOYKIBDzauLqA+bnVhLHztTWg==
X-Google-Smtp-Source: AGHT+IH2xlfCjxUf0Jmc6edmxLihr/sOKf0PRYUS3gP/gGJ3W6JuFQR6v8x9TcODLg2RTjj4/+/a7A==
X-Received: by 2002:a05:6512:ba6:b0:549:8f15:db2f with SMTP id 2adb3069b0e04-54990e6771cmr4714399e87.31.1741592462737;
        Mon, 10 Mar 2025 00:41:02 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bd032sm1379150e87.142.2025.03.10.00.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 00:41:02 -0700 (PDT)
Message-ID: <4d5212b3-3801-408c-9a5d-c6111189793c@gmail.com>
Date: Mon, 10 Mar 2025 09:41:00 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] iio: adc: add helpers for parsing ADC nodes
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <cover.1740993491.git.mazziesaccount@gmail.com>
 <e71c63c2f61135f9a8c7884525aab2c48f1e84c2.1740993491.git.mazziesaccount@gmail.com>
 <CAMknhBGQaqFZJsPAoauZL4S5MYtN05EOQ-BO2vw5gH+Z2RLOhw@mail.gmail.com>
 <54a031d0-df47-4baa-a23a-1a79c0922542@gmail.com>
 <20250308162928.72bd1d1b@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250308162928.72bd1d1b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/03/2025 18:29, Jonathan Cameron wrote:
> On Wed, 5 Mar 2025 12:54:33 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Thanks for the review David.
>>
>> On 04/03/2025 11:25, David Lechner wrote:
>>> On Mon, Mar 3, 2025 at 12:32 PM Matti Vaittinen
>>> <mazziesaccount@gmail.com> wrote:
>>>>
>>>> There are ADC ICs which may have some of the AIN pins usable for other
>>>> functions. These ICs may have some of the AIN pins wired so that they
>>>> should not be used for ADC.
>>>>
>>>> (Preferred?) way for marking pins which can be used as ADC inputs is to
>>>> add corresponding channels@N nodes in the device tree as described in
>>>> the ADC binding yaml.
>>>>
>>>> Add couple of helper functions which can be used to retrieve the channel
>>>> information from the device node.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>
>>>> ---
>>
>>>> + *
>>>> + * Return:     Number of found channels on succes. Negative value to indicate
>>>
>>> s/succes/success/
>>
>> Thanks!
>>
>>>> +int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
>>>> +                                         const struct iio_chan_spec *template,
>>>> +                                         int max_chan_id,
>>>> +                                         struct iio_chan_spec **cs)
>>>> +{
>>>> +       struct iio_chan_spec *chan_array, *chan;
>>>> +       int num_chan = 0, ret;
>>>> +
>>>> +       num_chan = iio_adc_device_num_channels(dev);
>>>> +       if (num_chan < 1)
>>>> +               return num_chan;
>>>> +
>>>> +       chan_array = devm_kcalloc(dev, num_chan, sizeof(*chan_array),
>>>> +                                 GFP_KERNEL);
>>>> +       if (!chan_array)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       chan = &chan_array[0];
>>>> +
>>>> +       device_for_each_child_node_scoped(dev, child) {
>>>> +               u32 ch;
>>>> +
>>>> +               if (!fwnode_name_eq(child, "channel"))
>>>> +                       continue;
>>>> +
>>>> +               ret = fwnode_property_read_u32(child, "reg", &ch);
>>>> +               if (ret)
>>>> +                       return ret;
>>>> +
>>>> +               if (max_chan_id != -1 && ch > max_chan_id)
>>>> +                       return -ERANGE;
>>>> +
>>>
>>> Should we use return dev_err_probe() on these to help with debugging a bad dtb?
>>>    
>>
>> I am not fan of using dev_err_probe() in a 'library code'. This is
>> because we never know if there'll be some odd use-case where this is not
>> called from the probe.
>>
>> All in all, I'd leave adding most of the debugs to the callers -
>> especially because we do not expect to have bad device-trees after the
>> initial 'development stage' of a board. The board 'development stage'
>> should really reveal bugs which prevent the channels from being
>> registered - and after the DT is correct, these debug prints become
>> unnecessary (albeit minor) binary bloat.
>>
>>>> +               *chan = *template;
>>>> +               chan->channel = ch;
>>>> +               chan++;
>>>> +       }
>>>> +
>>>> +       *cs = chan_array;
>>>> +
>>>> +       return num_chan;
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(devm_iio_adc_device_alloc_chaninfo_se, "IIO_DRIVER");
>>>
>>> We can make this less verbose by setting #define
>>> DEFAULT_SYMBOL_NAMESPACE at the start of the file. Then we can just do
>>> EXPORT_SYMBOL_GPL() throughout the rest of the file.
>>
>> I am not sure what to think of this. I use the good old 'ctrl + ]' in my
>> editor when I need to check how a function was supposed to be used. That
>> jumps to the spot of code where the function is. I'd like to see the
>> namespace mentioned there in order to not accidentally miss the fact the
>> function belongs to one.
>>
>> OTOH, I do like simplifications. Yet, the added simplification might not
>> warrant the namespace not being visible in the function definition.
>>
>>> Also, I would prefer if the namespace matched config name (IIO_ADC_HELPER).
>>
>> I had some lengthy discussion about this with Andy and Jonathan during
>> earlier review versions. In short, I don't like the idea of very
>> fragmented namespaces in IIO, which will just complicate the drivers
>> without providing any obvious benefit.
>>
>> https://lore.kernel.org/all/20250222174842.57c091c5@jic23-huawei/
>>
>>>> +
>>>> +int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
>>>> +                                         const struct iio_chan_spec *template,
>>>> +                                         int max_chan_id,
>>>> +                                         struct iio_chan_spec **cs);
>>>> +
>>>
>>> There are some different opinions on this, but on the last patch I did
>>> introducing a new namespace, the consensus seems to be that putting
>>> the MODULE_IMPORT_NS() in the header file was convenient so that users
>>> of the API don't have to remember to both include the header and add
>>> the import macro.
>>>    
>>
>> I do like this suggestion, and I believe this would be the balance
>> between getting the benefit of hiding part of the symbols - while not
>> unnecessarily complicating the callers. I know some people are opposing
>> it though. My personal opinion is that having the MODULE_IMPORT_NS() in
>> a header would be neatly simplifying the calling code with very little
>> harm, especially here where including the header hardly has use-cases
>> outside the IIO ADC.
>>
>> Unfortunately, the "safety" seems to often be a synonym for just "making
>> it intentionally hard". As Finnish people say: "Kärsi, kärsi,
>> kirkkaamman kruunun saat". :)
>> (Roughly translated as "Suffer, suffer, you will get a brighter crown").
>>
>> Let's hear what Jonathan thinks of your suggestion.
> 
> For this particular case my intent was that all the IIO exports that
> are suitable for use in simple IIO drives will be in this namespace,
> we just haven't started that conversion yet.
> 
> As such, having it defined from a header for this helper isn't a good
> thing to do.

Hmm. I agree.

>  Generally I prefer to see in driver code what namespaces
> are involved but do understand the other viewpoint. In this case I
> definitely don't think it is appropriate unless we go for a specific namespace
> for just this helper.

I suppose having the MODULE_IMPORT_NS() in the header would actually 
make the more fine-grained namespaces (like IIO_ADC_HELPERS, IIO_GTS, 
...) much more usable. That'd relieved the drivers from explicitly 
listing multiple namespaces while nicely limiting the visibility.

If IIO was my territory, I might want to ask people to go with that 
approach - but I am quite happy being a freeloade.. errm, I mean, 
bystander ;)

Thanks!

Yours,
	-- Matti

