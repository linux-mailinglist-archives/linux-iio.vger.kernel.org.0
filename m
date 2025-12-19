Return-Path: <linux-iio+bounces-27197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6EACD0045
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 14:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E68A30A7A73
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FB13233F4;
	Fri, 19 Dec 2025 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KE7qwfSA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fPrEVRod"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050AD31D74C
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766150074; cv=none; b=BLiyd3xc4ZsQoXr87V1ktT9bpNr5dp2eUOrPYCLotibzDkykQg9fShIz3lgA5hfJILGYjN3ZlSV3CpeKjO3hVmW3BQ5GfPdTZyCSNCfklFOrzeUMavHpDva+FM3L9IiczKQK3ovVUCjlUEvveU1GeylEM3eandXFOyfhhmDiEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766150074; c=relaxed/simple;
	bh=Qj7vGaEBpCtwKGYNjh0o6Zv0lf2d8jPNh0CwTd3emTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wt6QGAoa7L1orOh4RLbTaqXGQ3Gxf7iXvaOtv/OuhOqyuE5ojkTxHhQQw816fZ0FRhaDyuJQXiGVNKJUuOraFWl+p9TAxxDuuHWELERTSKYfDxUNXpnacWghloxXVyzbsmm4FcEPRv9c+U+URPHrLxEH9jYWQXp23R7hyjYpTBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KE7qwfSA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fPrEVRod; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBxYIQ092107
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fxIbdEjDeLf5+f+yETskdYR5vcJEABxLUEPWYYrSHhk=; b=KE7qwfSAShZWtwmd
	4c7ZeKikM9x7ZAVy8KAUZY7OFirEhkey8LhJLwHUzxJbohCQgT9JE7IotHfRMrbn
	xDl+Cp20Vc+YnfNGd8jTs2OU9jvG2zZiZfLhubtOpikBF3/K/On0Tw42780tKM2a
	ldpgELmcVNTY4pOIDqf7uUvoMLUVSDw5uIilq1khXvcazdUvmDczhPRpbwsM5i/D
	3dssEJOnB+VXJb57iSRaSsOYf/PP7a9Xv97OkRA+ssX+vQSAiVZ0n7A5zRkxlwBy
	v/qP0eJMx/tYDabRLSHWbhME6X6dvUorgCbrTbDhpk5jnMBeq5yXGPs8RE+Djqsy
	rp3GrA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2eardb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:14:31 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7ba9c366057so129847b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 05:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766150071; x=1766754871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxIbdEjDeLf5+f+yETskdYR5vcJEABxLUEPWYYrSHhk=;
        b=fPrEVRodx+4VMCaO/S6cisu+wb8TpU5oD1uADOyTjRUiiW0m1KXZLoPMlwMcXzH0rL
         94j540fFM11OYa3xT9qLdWqArxLp1rzZ7gzob+zMK7+O99//orxYDJxvAT4kFOu7/OxW
         Yd9YiHXtyQZeJgAct5vWeIrRUU1L7SFFjVOir4/m3I/h7syfzshbCYmBc3N/XJbh8i1f
         RvqoZBIuyTA4jJtZS3ibc1GqhD1BHUFPmb87oEOBYknilpxJFNcTfyWq8chD7fZHDyKK
         7PpDwyl2MJkhLOB/LQmJhhHJd07ehHTL6vktrOVqV3ATo/1GuBb+3ljYchCEHSxIFARz
         CulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766150071; x=1766754871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxIbdEjDeLf5+f+yETskdYR5vcJEABxLUEPWYYrSHhk=;
        b=LQinjKhNfKTQH8alj+3/E3vHvxzDQGnjvtdG7doa5+/wCm1c68Mafx/PCFBBwXO7hH
         vj2fwcxlxT0/n99WDyurM+3IkF3PfV8n7n2m4nkSN6Ln5DSAtUxQimohV9fTJ3UD/uGX
         dnTPzPmn6PTX6XrWy0GIXtVOg2WAsgU2FAzcsGIp8wQE/S/1G7V6v0SSrLPSFTV9/xdJ
         mboOwCy1GljsvcpkZg6tc5rO7z1w1/yqcTg/fvBfU++crUYtDBKzrnuu3VWV9e5TIApw
         iEGmDkEDxhM3gWlZO03PCDTy2K3IL5Rs6js5MoQpYOfyTX2hXjj7vcskzg8o1HWHBuHo
         BiqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX79lCABoMTKhH/ICyS2UL9LrtixnZrshn8Tg5TwaBTZulAsSb+xIXmCh2+rHGNrl25Sn+k3wHrdqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cvWYScx1cQ1TdSLJoyBM8Kg4/ypZWMF+sGHboBQU+/ovrzwU
	kIBulVKmPeB5VE0ALGh3qw26u84C+zEPPOa2y1tl8eck0bPIdykyZhGh98hEf31aOyFYLjLM0b6
	NXMGpqtrgE72V+1bISB4srmmINQ9Vq0f/jngujlHad770cb6mADzudF3mbHXztxo=
X-Gm-Gg: AY/fxX4ZtQ5OazBZ+KFFfMnM53RSqIONLh0uJUUG2LeOMqse+Iqj0+FL9bXI6hp8cPR
	hHj4bLvL7oqBJ27DCm8d/KDc+75ClOp6HTp2tWcvmzK5eOdj9FkjfEDt10yjOCFcO32X7rs27Wj
	BRd17t8Nf9m1Y4MPK4YyYy6t4YmAnAJS6Xqj09/GuGh4yGvCJj6raRyehzCCOFrG4P5XZI2eoBM
	z6Klx/cH+om5rzY7OZ9/vkBvKNqlDouDRKP7Ktyf/ECpi+5Vl3HhV7VS1YM9qbqZ+qif2DuuvdF
	odrREjGZNEPMaEjEUSSetCBF5tZ0DrEjplpK4qyKUrl9AKVRu6Gj0L6Yoo0SaoskACnAO/U/GP/
	aAfFELtfuXLL2jkM6yRYu0QfSwHsTS6HxRSC+mTanSw==
X-Received: by 2002:a05:6a21:9986:b0:34d:d030:6739 with SMTP id adf61e73a8af0-376a8eb799bmr2910253637.31.1766150070771;
        Fri, 19 Dec 2025 05:14:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsWOkmXwOjw6AZq27WEyY1HsavsSllg42Xn3GJb/gy2x9AA77YdkUx/Dpt9IAMKuz5drJhZw==
X-Received: by 2002:a05:6a21:9986:b0:34d:d030:6739 with SMTP id adf61e73a8af0-376a8eb799bmr2910218637.31.1766150070293;
        Fri, 19 Dec 2025 05:14:30 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cb25sm23305515ad.56.2025.12.19.05.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 05:14:29 -0800 (PST)
Message-ID: <693d9370-ea2f-4eee-bd24-9803c2b15c39@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 18:44:21 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
 <20251127134036.209905-5-jishnu.prakash@oss.qualcomm.com>
 <zzhzsc25f64tx6vrexshmm5uqi7saaff5teart6vvexlj4tcpo@czyhdfsk3khx>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <zzhzsc25f64tx6vrexshmm5uqi7saaff5teart6vvexlj4tcpo@czyhdfsk3khx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDExMCBTYWx0ZWRfX9MPGREGLsKj2
 h8RjSmrr9aN5ld4eEzesK5sO1tRZJKOqqwlgxMV0uFI/WfFsbN077Z5m8zCT0+SEnihtIMdsZRD
 rXnO0edAU4CuH/9psPRASlJltKW6G93ZFIaW2U+TbUeL0zXqjl/5m/lmDkycw8RMwnmjs+Y/MuH
 skoUxXTpSc+Zmj/doEtoSErqfol1/78bA2Qy/4XcRBvM1d5LSVjMqeR59xw2zDkvlVByAO6MWvF
 9sfwM3vVp62zNbW5GIUsZOtethkBWXDo3rr6weBRbNFAPStMR8QHrgHJ7qb2Vdu8kvNfwgpKS1w
 2r3hmGyLJLx1nt6XiaKSkaGLTNVEteHT16o6fRJb3lZ5V2cega+anNus9XlsC1RLhYxpXps4f8i
 MtjsJifROSaLOGwLolmY7tsF1LELyWLOlTzW28hFymqduOA6q/u4Xy3O4/sUauvdCmrhiGmAJfA
 MdC9ZmGi9iR+eXiPsPg==
X-Authority-Analysis: v=2.4 cv=W+c1lBWk c=1 sm=1 tr=0 ts=69454fb7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mR9g3s2PQlfax8CwdagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: G0MPW4kuqWYFhvvQg6E7KxvkYIF-GXXO
X-Proofpoint-GUID: G0MPW4kuqWYFhvvQg6E7KxvkYIF-GXXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_04,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190110

Hi Dmitry,

On 12/6/2025 7:54 AM, Dmitry Baryshkov wrote:
> On Thu, Nov 27, 2025 at 07:10:36PM +0530, Jishnu Prakash wrote:
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---

...

>>
>>  drivers/thermal/qcom/Kconfig                  |   9 +
>>  drivers/thermal/qcom/Makefile                 |   1 +
>>  drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 530 ++++++++++++++++++
>>  3 files changed, 540 insertions(+)
>>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>>
>> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
>> index a6bb01082ec6..1acb11e4ac80 100644
>> --- a/drivers/thermal/qcom/Kconfig
>> +++ b/drivers/thermal/qcom/Kconfig
>> @@ -21,6 +21,15 @@ config QCOM_SPMI_ADC_TM5
>>  	  Thermal client sets threshold temperature for both warm and cool and
>>  	  gets updated when a threshold is reached.
>>  
>> +config QCOM_SPMI_ADC_TM5_GEN3
>> +	tristate "Qualcomm SPMI PMIC Thermal Monitor ADC5 Gen3"
>> +	depends on QCOM_SPMI_ADC5_GEN3
> 
> This module depends directly on the Gen3 ADC driver. I think you can
> drop a separate "common" submodule.
> 

Yes, I can do this in the next patch series.

>> +	help
>> +	  This enables the auxiliary thermal driver for the ADC5 Gen3 thermal
>> +	  monitoring device. It shows up as a thermal zone with multiple trip points.
>> +	  Thermal client sets threshold temperature for both warm and cool and
>> +	  gets updated when a threshold is reached.
>> +
>>  config QCOM_SPMI_TEMP_ALARM
>>  	tristate "Qualcomm SPMI PMIC Temperature Alarm"
>>  	depends on OF && SPMI && IIO
> 
> 
>> +
>> +static struct adc_tm5_auxiliary_drv adctm5gen3_auxiliary_drv = {
>> +	.adrv = {
>> +		.id_table = adctm5_auxiliary_id_table,
>> +		.probe = adc_tm5_probe,
>> +	},
>> +	.tm_event_notify = adctm_event_handler,
>> +};
>> +
>> +static int __init adctm5_init_module(void)
>> +{
>> +	return auxiliary_driver_register(&adctm5gen3_auxiliary_drv.adrv);
>> +}
>> +
>> +static void __exit adctm5_exit_module(void)
>> +{
>> +	auxiliary_driver_unregister(&adctm5gen3_auxiliary_drv.adrv);
>> +}
>> +
>> +module_init(adctm5_init_module);
>> +module_exit(adctm5_exit_module);
> 
> We really need to make this work with module_auxiliary_driver-like
> macro.
> 

I tried doing this again now, but I'm not sure if the way I found is fine.


Just to recap, the main issue with using module_auxiliary_driver() directly,
which I discussed with Jonathan here earlier: (https://lore.kernel.org/all/20250301032901.7b38fed4@jic23-huawei/)
was that it is a macro definition which uses its input argument to
generate function names. So if I have a line like this:

    module_auxiliary_driver(adctm5gen3_auxiliary_drv.adrv);

it will generate function definitions like this, due to text substitutions:

    static int __init adctm5gen3_auxiliary_drv.adrv_init(void)

which will fail compilation.



I see that in other drivers where module_auxiliary_driver() is used, there is a 
"struct auxiliary_driver" initialization just before that initialized variable 
is passed to module_auxiliary_driver(). I tried making a similar change here now:


    -static struct adc_tm5_auxiliary_drv adctm5gen3_auxiliary_drv = {
    -       .adrv = {
    -               .id_table = adctm5_auxiliary_id_table,
    -               .probe = adc_tm5_probe,
    -       },
    -       .tm_event_notify = adctm_event_handler,
    +static struct auxiliary_driver adctm5gen3_auxiliary_driver = {
    +    .id_table = adctm5_auxiliary_id_table,
    +    .probe = adc_tm5_probe,
     };
    
    -static int __init adctm5_init_module(void)
    -{
    -       return auxiliary_driver_register(&adctm5gen3_auxiliary_drv.adrv);
    -}
    -
    -static void __exit adctm5_exit_module(void)
    -{
    -       auxiliary_driver_unregister(&adctm5gen3_auxiliary_drv.adrv);
    -}
    +struct adc_tm5_auxiliary_drv adctm5gen3_auxiliary_drv = {
    +       .adrv = adctm5gen3_auxiliary_driver,
    +       .tm_event_notify = adctm_event_handler,
    +};
    
    -module_init(adctm5_init_module);
    -module_exit(adctm5_exit_module);
    +module_auxiliary_driver(adctm5gen3_auxiliary_driver);

With this, I get the following error:

    drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:513:10: error: initializer element is not constant
      513 |  .adrv = adctm5gen3_auxiliary_driver,
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~


It looks like the above definiton of adctm5gen3_auxiliary_driver is not considered
a compile-time constant. I made the following modification to fix this:

    -static struct auxiliary_driver adctm5gen3_auxiliary_driver = {
    +static const struct auxiliary_driver adctm5gen3_auxiliary_driver = {


And with this, the code does get built, but with warnings like this:


    drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c: In function ‘adctm5gen3_auxiliary_driver_init’:
    ./include/linux/device/driver.h:260:20: warning: passing argument 1 of ‘__auxiliary_driver_register’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
      260 |  return __register(&(__driver) , ##__VA_ARGS__); \
          |                    ^~~~~~~~~~~
    ./include/linux/auxiliary_bus.h:253:30: note: in definition of macro ‘auxiliary_driver_register’
      253 |  __auxiliary_driver_register(auxdrv, THIS_MODULE, KBUILD_MODNAME)
          |                              ^~~~~~
    ./include/linux/auxiliary_bus.h:287:2: note: in expansion of macro ‘module_driver’
      287 |  module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
          |  ^~~~~~~~~~~~~
    drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:517:1: note: in expansion of macro ‘module_auxiliary_driver’
      517 | module_auxiliary_driver(adctm5gen3_auxiliary_driver);
          | ^~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/auxiliary_bus.h:250:58: note: expected ‘struct auxiliary_driver *’ but argument is of type ‘const struct auxiliary_driver *’
      250 | int __auxiliary_driver_register(struct auxiliary_driver *auxdrv, struct module *owner,
          |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~


Is it acceptable to have the above code changes to use module_auxiliary_driver(),
even with the warnings generated? 

Or do you have any other suggestions?

Thanks,
Jishnu


>> +
>> +MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_IMPORT_NS("QCOM_SPMI_ADC5_GEN3");
>> -- 
>> 2.25.1
>>
> 


