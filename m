Return-Path: <linux-iio+bounces-27742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B267FD1DD8E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 515FF3058A2A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA6637E2E5;
	Wed, 14 Jan 2026 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nRlFufa3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dwJliYWE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884638A29B
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385078; cv=none; b=YIBV8JGtLibE/F2Qj1aoyYZAqLGbI8tQFw1LW51GHRtVeHATQD0J3iGISkK2nJhcm0q2gTY6jhZ1HGJc9XVErMa101Xf8Alf+njcTRBRXzXOwCEPHzqiTQuhoOdGmpAmQXPDlaJzmo6iIg8w+w9vdoxDoBTL7r3kTSgyJ0f9Hxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385078; c=relaxed/simple;
	bh=bk5+NHu/P6gafqqhb4aOu+UXDpyWuvNVnGbIOZ2XFnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZN94jDiPqV/eBorC7t2eUbLJWcwX5DW59ylx1w3/fD6KVVBhSehyu9BkYdchRKfZ5cyUQWZeqztoLeVt3WSpbktCLuWqHFFhlzk7j7dStEbV3inRsOZLoyh2vR00kVWojnLB1xEjHDK0l0+1DcZDEgUU4E8G/eKEECdndRcbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nRlFufa3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dwJliYWE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E7jK62147934
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 10:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LwJOhAcoLnubcI+OpTANBa1Q6k/a05uNgL+zKTmJFTM=; b=nRlFufa38/C8KQB+
	t7XdLj/CP9XUzHX6kWnl2Rlc1rwX9KIJjikY9wM/5Q9iySLu2B4fkeoDvqn516oK
	uyod7fBAZCc0pYL9Y8MLdxf+/T0cG1b9rZClV0BFouqc1pjgowpokTlVjo5zqXUw
	Y1fjQRDlfBDN/RxQtxSL6x+icmC6Hr8WfrKHDm3Ymz1mhqD4qQZWf2V4rtaZsXAB
	TIX8MX7TcSdmk3/LcXDPpKdGIK1crmazxy22Fha9ntRaQT1xPYvkwIquWSlXrOcJ
	CiIA48AHc1QvRap1tDjZv5yL7dZmMsIpi/02o7vhIhh2VvgP3ketv7mM5NDUpx8M
	XC4/+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp6ragkkk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 10:04:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c532029e50so14655085a.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 02:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768385076; x=1768989876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LwJOhAcoLnubcI+OpTANBa1Q6k/a05uNgL+zKTmJFTM=;
        b=dwJliYWEM9qwTmFj8UPlToeRDAesNCO+ZXHdrCtUre5f4ru8Q4gKXHH+JSdavV4RTe
         DhQBEzWS5O1y/+yh+6HYgyYH1gQzAcZDbGyuwnAKCFdWpu5SITmB7d6ZXA/mRr/SlXTL
         BNb8OtWKUwK3NgpTrr8Q0ZXREknbXGqvK8nnzhMTeLSNje93Om40eS3vtHKAJC/1w8Bv
         BhgWEFMO8UdqDpEPYNg+QEyK4BO9fXkxvnpz8oI+cXZpRHpdYUaZygw5+SZVE+80P8uo
         Zq7TRDdB48gr2+dKJRJCxSdIQwY89/EwUqbsA31uEvk4zpA7V5vLQj0iLyXswjlLJ+aZ
         EzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768385076; x=1768989876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwJOhAcoLnubcI+OpTANBa1Q6k/a05uNgL+zKTmJFTM=;
        b=W/ErBH9V+wBD/EUifEZvcvyAp7elqWgihmsVwWGADIyW0vE6NLqZSs0D7QyEqb6tCU
         ZUAgSEUhwmE18W+l1n5Yk+J6MxJBCehg/7RfZsuXiXEGZ4akqIX14ZQqWLMKY3dfON37
         UZTVhdaAKqHGc44QXj0IB8JOrNMk7Rf+Bcezx6yyHtrMz3I4zzkOJH6eWEA9BauOA+AP
         P96eCwI5rqQOzjZjyzR3LpL6yd9L+oKNGuRZkeL1eI8Dc1nxyFWWc1wpzNb9O5Pomn4V
         DFS712jMEgYI65Wx0s+pvZNXnnYrilSu2U1N/Om6WHB7vXYF6bMLavmka69HtrA8v1QW
         LGng==
X-Forwarded-Encrypted: i=1; AJvYcCVCviZATQ50HFi0+nYU8O12qv1KffslZqh7uEVyQuHiGx9LWcJlYHHyQMMM4uXewxFWOjEvrtSlNBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJ2l+n1zAqu/nVfrfNv+ZdxVYr0kmA8tZ1CiSb2fKI8djyX7K
	qL2fG5YGJNjiZa5gfdaQtFw4CJ2BxZNotjzOW6+JPKw0P1N7V/LB/4lYzmDxFtXgP5bo1HfaMqY
	D9AGKUMrvWVLeK2a9myXzU6D0UhYcm0/pyW2wMNemZyI0AUbQOPz4VCKsyTYIJCY=
X-Gm-Gg: AY/fxX5oPeD5HVPH7mET0w8MjiXvDrZyNUHZCfHgwa6pJWj3MvRZBxdhMrjK4Wpcuz6
	9awn/+t3BYdWdkDj+BS2BuX9i5l8IV1/CurTbyW3La4lZN21JFU+WRyoSAJJ1WOCcY5hsAA8+1S
	2plhoucZNVLRCgFcqwlt64qkD37Q5Z+DFEVVCNjXD2balsG9Juq4DYCy9801I81uueeBDXV1DC6
	sPX2rQpKG0/c2cdwPghN8L+zFU3lsWv5UM1yNzc2m9bE/W5OCveQgcOvAYB0kZsyc3BR2JjGrr7
	nR2/ciHYAl1pCT6Qm4RnXcvIkCqRa0iV8Zu0lSyekQsmJM6gxuZkz5vI7xcn7C2LeABhTyiqlMg
	9nak/ur7blP5FbmppIK62MHBIKz2aw0htbIYU2qc3qKfnEjIm3zUq9ip2gtpdl/MZa/Q=
X-Received: by 2002:a05:620a:4411:b0:8b9:e0ea:af3b with SMTP id af79cd13be357-8c52fb74bd4mr221985885a.5.1768385075590;
        Wed, 14 Jan 2026 02:04:35 -0800 (PST)
X-Received: by 2002:a05:620a:4411:b0:8b9:e0ea:af3b with SMTP id af79cd13be357-8c52fb74bd4mr221982985a.5.1768385075013;
        Wed, 14 Jan 2026 02:04:35 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b22c3absm22533208a12.0.2026.01.14.02.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 02:04:34 -0800 (PST)
Message-ID: <dd877ea8-b634-4cc9-8280-08663f82776d@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 11:04:30 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
        andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
        sre@kernel.org, sboyd@kernel.org, krzk@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
        melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
        ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
        luca.weiss@fairphone.com, mitltlatltl@gmail.com,
        krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
        kernel@collabora.com
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-6-angelogioacchino.delregno@collabora.com>
 <aWdaWY2tWUMllOHH@smile.fi.intel.com>
 <8bf79979-0946-4ed9-b8d4-c442a6e54833@collabora.com>
 <aWdbPze-f_2_5EbL@smile.fi.intel.com>
 <401c5e7b-ff33-44e8-98a5-8cc6af4f2a87@collabora.com>
 <aWdcy2ouQHtkPd6q@smile.fi.intel.com>
 <647b4acc-3310-4329-ac7a-77e86bab74a3@collabora.com>
 <aWdk-RP-59cJeCBo@smile.fi.intel.com>
 <ae46b504-58d3-4042-be05-f31e9e01091b@oss.qualcomm.com>
 <aWdn_j7SOKq97vpY@smile.fi.intel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aWdn_j7SOKq97vpY@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA4MiBTYWx0ZWRfX6nvq1aloiIJc
 iFu8nn9uPJQCjpunvTDLQ2qyhXToYIp3j76IHVL3h9Jy3GOrDUNMSUaxxzkc/7Jh6uQaPZHP7YP
 JqA/JyN6ZAAH6jkorAjt0WKt1HD12vM8sp176K0VLXMy1ZF5lMbtljeohckO1aZTheCV0f2b/ps
 2ikH51tATff8sXQ8pf1CA4ZUva6NQCRnwV0CqqGg6D+3s/f5+pD569r9+Mm/U3bljfPOjd9Uela
 KydUnwaLWtxdJonS3vne3ta9lfE5DiyA4ed5pYpi/o0FsfJ8OSWJk+IwLyRGsAnJvhU4ONEE5CL
 JDRqH0Fopv7fWP0rYvjndqMNXc7i/qQw/Nzy+7sUqe3Fr4OHNlE0OybAt/udH7mD2VGD1sZWGc2
 fAELY7Fw/QM/zPAH7XCYteGBEddBOX7Q24xwPM3DMbEc3P3WCe1HwFRRmLZIpzUGcvT8JZMiixm
 q8fPMebEjfOabtd/ItA==
X-Proofpoint-GUID: pB3lgl8QbSguPuA0tdnifQQMDMfwOoiZ
X-Proofpoint-ORIG-GUID: pB3lgl8QbSguPuA0tdnifQQMDMfwOoiZ
X-Authority-Analysis: v=2.4 cv=L/EQguT8 c=1 sm=1 tr=0 ts=69676a34 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=K6O-kMeRs0nb6JyVbzgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140082

On 1/14/26 10:55 AM, Andy Shevchenko wrote:
> On Wed, Jan 14, 2026 at 10:47:20AM +0100, Konrad Dybcio wrote:
>> On 1/14/26 10:42 AM, Andy Shevchenko wrote:
>>> On Wed, Jan 14, 2026 at 10:09:45AM +0100, AngeloGioacchino Del Regno wrote:
>>>> Il 14/01/26 10:07, Andy Shevchenko ha scritto:
>>>>> On Wed, Jan 14, 2026 at 10:03:57AM +0100, AngeloGioacchino Del Regno wrote:
>>>>>> Il 14/01/26 10:00, Andy Shevchenko ha scritto:
>>>>>>> On Wed, Jan 14, 2026 at 09:59:40AM +0100, AngeloGioacchino Del Regno wrote:
>>>>>>>> Il 14/01/26 09:56, Andy Shevchenko ha scritto:
>>>>>>>>> On Wed, Jan 14, 2026 at 09:39:52AM +0100, AngeloGioacchino Del Regno wrote:
> 
> ...
> 
>>>>>>>>>> +	struct regmap_config sdam_regmap_config = {
>>>>>>>>>> +		.reg_bits = 16,
>>>>>>>>>> +		.val_bits = 8,
>>>>>>>>>
>>>>>>>>>> +		.max_register = 0x100,
>>>>>>>>>
>>>>>>>>> Are you sure? This might be a bad naming, but here max == the last accessible.
>>>>>>>>> I bet it has to be 0xff (but since the address is 16-bit it might be actually
>>>>>>>>> 257 registers, but sounds very weird).
>>>>>>>>
>>>>>>>> Yes, I'm sure.
>>>>>>>
>>>>>>> So, what is resided on address 0x100 ?
>>>>>>
>>>>>> I don't remember, this is research from around 5 months ago, when I've sent
>>>>>> the v1 of this.
>>>>>>
>>>>>> If you really want though, I can incorrectly set max_register to 0xff.
>>>>>
>>>>> Why incorrectly? Can you dig into the datasheet and check, please? We don't
>>>>> know what is the 0x100 address means.
>>>>
>>>> I don't have any datasheets for Qualcomm IPs.
>>>
>>> Hmm... Can we have somebody from QC to check on this?
>>> Perhaps Dmitry?
>>
>> 0xe6 is the last usable register today
> 
> Thanks for checking!
> 
>> But I wouldn't mind either 0xff or 0x100 because I don't want
>> anyone to pull their hair out if a regmap access is dropped some day..
> 
> There is actually about the exact window size where registers are belong to the
> same entity (subdevice). As in the HW world most of the things are stuck with
> power-of-two numbers, and taking into account the naming of the field, I do not
> believe one provides a 257 (256 + 1 = 2⁸ + 1) register _windows_ ("s" is also
> important here, as it points out to the pattern) for the subdevices. I bet the
> 0xff, i.e. 256, is the *correct* window from the HW perspective.

Right, [0x100n, 0x100n + 0xff] inclusive is the reserved register window
for all Qualcomm PMIC peripherals, so I guess 0xff is the correct choice
here

If a peripheral is more complex, it's split into a couple of these
same-sized blocks

Konrad

