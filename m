Return-Path: <linux-iio+bounces-16411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B405A4FCD7
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 11:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCDB16558E
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634732206AF;
	Wed,  5 Mar 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJNFgGSg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56659219310;
	Wed,  5 Mar 2025 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172082; cv=none; b=HWdtyFh4a5zNwk/36c1wR7qQhkgwHf4VnAM6Y6NHCkCHDycjBmK1VNqki8I+aVjzb6vvlVKqtSzXUl86b7oAVTzvOnDPKAuzU0kSMAHNFyaoPvFpYPON8TaRND+NdBeDXzG9JpAr6uDyQSTJ2+prjahqUTYGuMjBV/tsr9x2b94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172082; c=relaxed/simple;
	bh=QoUC6Qhyxqtfrpp/Ewhq5WKUwH5QMPUb0vC0OYmQgHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfhwepmGIm8cJ9+mkU0ypcaXABDSynLx7R9tno5WFO49sB3fK65g3J6XPbfwas4AG7c3DWfboHaAur8QNaUoWb6LjWJjs29o24ZE7rtCRX5cdvOgvd4Oc57s/oFzdmSlh7JtwYpn2L3WfgECm4eT+DTuNxzCFaAEzvuavvlF3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJNFgGSg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5495c63bdc0so4384750e87.1;
        Wed, 05 Mar 2025 02:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741172078; x=1741776878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Myb8iOfwo/K4CWy++bb3w2FblFyh4mmShUmyEU2xmU=;
        b=mJNFgGSgWQt3++aNA/7vnhD9m7F/4oQulNHGVBO2WjhRnR0tGV49t7PXR94m5c0O4U
         l2AiOB95YMJT09KNZyauQ05tSAAuSbKlLsA9LWZQN7as5BiJ0gjziC9eudWw6XIWjsIu
         1SyBIA2YCMkm30NHGOX+sWLAdqzATlWsaZu7FC8bhVNpeG/V1+8axi93RUO8cSRdJcbg
         OoOG9lufXDIf3y1ai8kmg58KbPWKyopYAzCmDiwzLWosGj0JXnFr4Vk44+lHU9kidXF6
         t9LjIRi6fyquWXic95qaxZW75ssF3VAgGAY2f7na4QM6LGjOu8N5tDfjv1ojxSB+8nQF
         tyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741172078; x=1741776878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Myb8iOfwo/K4CWy++bb3w2FblFyh4mmShUmyEU2xmU=;
        b=tJd90vOXqxMFdVNG5PxK84wkyUj0tlee8JbgxCXiFSxffs7MJwEaB0ufwZsl1Sk59u
         OYmIWTl73rjH89VvxO/lSdpiY8r/qZJdm7PlqfdR9XCUCmvPH/TKjYcz7EPwA3YmTAVF
         C+eRJHzOCjxudfG5N+72dkcvvqt8Lm8o4kJmgKKSuLLCAw5rrrBjU7J3XKOdgV4jzUEo
         c9R5EfwqhxmL06xeFAWVG8cCBVqqBoYBK+m1CZlmEI7LkQW+Tm0IQrxoNnbaEYazMMw8
         ige9ecQ8fuaNkiDHCKr0ULWzT5FvC83iPvttKaM5i9ex15UHlqhXeAiKHVt5YDf5IHfr
         o50g==
X-Forwarded-Encrypted: i=1; AJvYcCUz1tzYld3sx9YZPavL0CNeHUN4N86lR8Ms9xA4BZDhHRJFEbp6oFlklTiR7UC+ooghj0q38pWhLfBbghBy@vger.kernel.org, AJvYcCVo8iXR0Je7164o1953bVC1QppG3flFG0iXWdmO57Crgh9kNZPzTq6HtdFyY6VfaQvgpiMGd/UxfN9YYg==@vger.kernel.org, AJvYcCW9crrH7X4LRCMiRT3YTRyX/YlNCRPAqDqgSJl761GC/HM1n30bSMEQB7XODyUrEUNRs37KLkC7GtIP@vger.kernel.org, AJvYcCWhnVMOa+vlzgZk4sf1H5zm5Nz3R1pNZt3T4Op5Su+FqPxpaYOft9Ln2YVhZOY5O+Zk2c5ovmqw0xcW0it75dcrhBE=@vger.kernel.org, AJvYcCX2byrfum9cVQhaqLYHpMmqjLGvT+QhO6ODQoZMBrLSVaf8Ucvb455HPdQwsAmMhrbbhMW70Ot9K1Rf@vger.kernel.org
X-Gm-Message-State: AOJu0YzGRtaRLb1+Vj7lPUxnSlbRgiJBU4+QW+P/WYa+zBq/jC5/lsYA
	WonVIXWQAZiawuAB1qNyjWYNT0m7i6vuzn4DxIXrC1QcIReJBedg
X-Gm-Gg: ASbGncsJDd0zsbKZx/r0p+O83DQQRKnkXJfS1MfszU4cQ75gA3k2brD8qsKkMlkLER5
	gAFXfmMPUNipc8bG0qf86F8/V6FYIaPv+MRvHWwQtAa2hxA23hufXFSVaKym5obShFs0YnL/CsC
	9LytseQr2kMuJgt0rqeb/EQg+0eQ/vDnvGtmO11b0mJ+6J4Wbo0F9luwPZOLlGXcT2KjVQo2mq+
	cFRD/B15VycJfkYhjD+c+XgW+3gTPvDkVCnaUgierhgVtiSUmgVCoEH//fOIbYeFkdIxx5762Pd
	pdrMDPWdpNP4J7He3JOP5hjr/xdIt0q/09FxPrKX+xDWV05aQE+XAXEAWef5gtJecXjLAZtNt4l
	5CN5x02JTa+FhhGszN1Mw9B7tZA==
X-Google-Smtp-Source: AGHT+IG7+dALkj4mnhqEtYuKNaMtYCVDDovKQLGo6i+y4ha0bmLUd9DW+/Gn+j0UXQCjVleXTiXGSQ==
X-Received: by 2002:a05:6512:2214:b0:545:746:f36a with SMTP id 2adb3069b0e04-5497d376350mr1006837e87.34.1741172077938;
        Wed, 05 Mar 2025 02:54:37 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494ca38eaesm1601129e87.124.2025.03.05.02.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 02:54:35 -0800 (PST)
Message-ID: <54a031d0-df47-4baa-a23a-1a79c0922542@gmail.com>
Date: Wed, 5 Mar 2025 12:54:33 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] iio: adc: add helpers for parsing ADC nodes
To: David Lechner <dlechner@baylibre.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
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
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAMknhBGQaqFZJsPAoauZL4S5MYtN05EOQ-BO2vw5gH+Z2RLOhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the review David.

On 04/03/2025 11:25, David Lechner wrote:
> On Mon, Mar 3, 2025 at 12:32 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> There are ADC ICs which may have some of the AIN pins usable for other
>> functions. These ICs may have some of the AIN pins wired so that they
>> should not be used for ADC.
>>
>> (Preferred?) way for marking pins which can be used as ADC inputs is to
>> add corresponding channels@N nodes in the device tree as described in
>> the ADC binding yaml.
>>
>> Add couple of helper functions which can be used to retrieve the channel
>> information from the device node.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---

>> + *
>> + * Return:     Number of found channels on succes. Negative value to indicate
> 
> s/succes/success/

Thanks!

>> +int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
>> +                                         const struct iio_chan_spec *template,
>> +                                         int max_chan_id,
>> +                                         struct iio_chan_spec **cs)
>> +{
>> +       struct iio_chan_spec *chan_array, *chan;
>> +       int num_chan = 0, ret;
>> +
>> +       num_chan = iio_adc_device_num_channels(dev);
>> +       if (num_chan < 1)
>> +               return num_chan;
>> +
>> +       chan_array = devm_kcalloc(dev, num_chan, sizeof(*chan_array),
>> +                                 GFP_KERNEL);
>> +       if (!chan_array)
>> +               return -ENOMEM;
>> +
>> +       chan = &chan_array[0];
>> +
>> +       device_for_each_child_node_scoped(dev, child) {
>> +               u32 ch;
>> +
>> +               if (!fwnode_name_eq(child, "channel"))
>> +                       continue;
>> +
>> +               ret = fwnode_property_read_u32(child, "reg", &ch);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               if (max_chan_id != -1 && ch > max_chan_id)
>> +                       return -ERANGE;
>> +
> 
> Should we use return dev_err_probe() on these to help with debugging a bad dtb?
> 

I am not fan of using dev_err_probe() in a 'library code'. This is 
because we never know if there'll be some odd use-case where this is not 
called from the probe.

All in all, I'd leave adding most of the debugs to the callers - 
especially because we do not expect to have bad device-trees after the 
initial 'development stage' of a board. The board 'development stage' 
should really reveal bugs which prevent the channels from being 
registered - and after the DT is correct, these debug prints become 
unnecessary (albeit minor) binary bloat.

>> +               *chan = *template;
>> +               chan->channel = ch;
>> +               chan++;
>> +       }
>> +
>> +       *cs = chan_array;
>> +
>> +       return num_chan;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(devm_iio_adc_device_alloc_chaninfo_se, "IIO_DRIVER");
> 
> We can make this less verbose by setting #define
> DEFAULT_SYMBOL_NAMESPACE at the start of the file. Then we can just do
> EXPORT_SYMBOL_GPL() throughout the rest of the file.

I am not sure what to think of this. I use the good old 'ctrl + ]' in my 
editor when I need to check how a function was supposed to be used. That 
jumps to the spot of code where the function is. I'd like to see the 
namespace mentioned there in order to not accidentally miss the fact the 
function belongs to one.

OTOH, I do like simplifications. Yet, the added simplification might not 
warrant the namespace not being visible in the function definition.

> Also, I would prefer if the namespace matched config name (IIO_ADC_HELPER).

I had some lengthy discussion about this with Andy and Jonathan during 
earlier review versions. In short, I don't like the idea of very 
fragmented namespaces in IIO, which will just complicate the drivers 
without providing any obvious benefit.

https://lore.kernel.org/all/20250222174842.57c091c5@jic23-huawei/

>> +
>> +int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
>> +                                         const struct iio_chan_spec *template,
>> +                                         int max_chan_id,
>> +                                         struct iio_chan_spec **cs);
>> +
> 
> There are some different opinions on this, but on the last patch I did
> introducing a new namespace, the consensus seems to be that putting
> the MODULE_IMPORT_NS() in the header file was convenient so that users
> of the API don't have to remember to both include the header and add
> the import macro.
> 

I do like this suggestion, and I believe this would be the balance 
between getting the benefit of hiding part of the symbols - while not 
unnecessarily complicating the callers. I know some people are opposing 
it though. My personal opinion is that having the MODULE_IMPORT_NS() in 
a header would be neatly simplifying the calling code with very little 
harm, especially here where including the header hardly has use-cases 
outside the IIO ADC.

Unfortunately, the "safety" seems to often be a synonym for just "making 
it intentionally hard". As Finnish people say: "Kärsi, kärsi, 
kirkkaamman kruunun saat". :)
(Roughly translated as "Suffer, suffer, you will get a brighter crown").

Let's hear what Jonathan thinks of your suggestion.

Thanks!
	-- Matti


