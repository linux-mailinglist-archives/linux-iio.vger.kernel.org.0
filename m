Return-Path: <linux-iio+bounces-26817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A40CA9E7A
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 03:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 001A2318726B
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 02:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9630262FFC;
	Sat,  6 Dec 2025 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o+b0DSRb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jA7w01lk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E09519E99F
	for <linux-iio@vger.kernel.org>; Sat,  6 Dec 2025 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764987756; cv=none; b=kJ3b6YKlYkP8J+NK+6GGP1qFU2IvQ17H2TrM+Y+XdBrB4m3HlcUdIB5PsSh6yZ64xEu7XiOyfD5O2Rr/9FAdgduwBP7zpV/nGX2fO9Bx9zpJZS+2ISm4qBpf1N2x8piIFAx6rv5B3r41TakzbFjUORMBSur6HFB2A48/VpbvBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764987756; c=relaxed/simple;
	bh=FdA26V6/kuq4+n38f/eQzg5alLmGuk8eDcsxclMVIp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoTN1+cUFYPq6t1obN6+fpauDrj+A72m7f2fejOBxjgOYrmzI+hsVPyRcYQ5Q45lFuIvWyumBoRhADJs1iuZ4lTv499udvI9WpGGe69b0jaINMc13th51o48/+u2pI/0bM+3S5Cy6h1ON5LNTNYUmu4gPmgW4u1w5lVyxfwDzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o+b0DSRb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jA7w01lk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5K1oT81643629
	for <linux-iio@vger.kernel.org>; Sat, 6 Dec 2025 02:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/QTADq34APjf0jnHgq3sDYnB
	1PQtEreDxx/2XsVFlOc=; b=o+b0DSRbxNoeiUSMKI6lc844SgUAbTvAa6LweoJ7
	aNFmhCbEa5HF7b0AzAfz9kI2NUtl7pJFgc9OKgJx6EwGxH1fyW6wkQw8mvhMqVoF
	RPR1Z/KYWDeUQrm3VVpYdE9gn5GMCohk4gXf0cluyrF/86TyNfhb/40OWmgv57sM
	klEPDt1pAS2bR1oLMc/FbY74Ch5w34jee7ULtMSQ5wlN4Tof9x8KeiiKgYoETDWU
	qQyt5A7zTZawIhAruy4GTb1AJc22eNkptTa5+7TrXdRlDZbNhGYJvV8r4/Jxjiv0
	rCujk83vV/av1ZOtbRdkG1Dvg+fVBOnsF7vojZZLlScXCQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4av62u0q49-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 06 Dec 2025 02:22:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b30b6abb7bso560139785a.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 18:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764987751; x=1765592551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/QTADq34APjf0jnHgq3sDYnB1PQtEreDxx/2XsVFlOc=;
        b=jA7w01lktzZY0cKaZ/6/VjoD/s6izpVi3F0Fq52h70t98Hl98rrtB/HU9+LUSYwTRP
         /S4t0I9otJR/0nMfgq8X4SyQI6AOr/N2dofrTUnzFtiTfrxTK0JzRSV/IVfP8u27E5kC
         SXMp4wOnGiiXVwnpyYdCD0w293joWNXkxb01gLdn4scfU5o7/bZpoDlyJVDf0KEgcZwi
         lMU1fcD0CQDMUB745EfT7clvGIVJGdN3ChOupF3wnPmcU6UzqYCUQRAX5+aAjdhha0R4
         FvT4HtgbQr9Kb2cbs6yrtrsyxAgJ/cCC2aFARh817gkcKvgiw3CuiM3GwHbgmqmijtSO
         XImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764987751; x=1765592551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QTADq34APjf0jnHgq3sDYnB1PQtEreDxx/2XsVFlOc=;
        b=hoJhrnArrs4iHETnOj6u3agHFr+FUMYTm2EuCK/Qxkxq7wMwFVcnDFfXBNEMC8Ug6H
         76Fws+CT7lQ66hmPWRMZ49aJ6KYKcdwqno7bZLldZq8DVd3IpdcGT1nkRRsBQ13mNKc8
         ol/C+gL/wqtAIvdHssGg2IcL3F5SFH6x4F33xhDi6Dx0g0ayi6GbWGJPex3BGjy2ceuY
         fEoZNbDwpRfzY/DcahhbViErbNIp7QxpUCI5uHkzxP9UxOvy7D96fnG080/RHn/eq7FM
         J9c6I62YgmXP1wCw2asn4KG+Egs0JODlZIR4TflqdyCLF5Gx2BhPVksnAIs+R/AjdYr4
         49tQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2qq06Vb0d4VdTzNTWP/tk7x1kb95I25vraMjfNGZS7ET9Z3Kt3aALzVLt7Arq8goC9CtHvuNgOUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjXxs2GF6oYkJIp7wp1NXfjREdMYEt5e0eHaa1MRj5TQUodKBM
	vHN/Vu0xRg+QU2ieieFB2UNz/z6VctK19CW9+GkK8ik2EO/jZ2P5mvrdTm7BPhL76P1CSe45Obu
	Hf+T1H8iz7g7S5HXwGEozutn/lJflg8y0DStbaVavLlLMcc0lbpr4/F+n5Pjlchg=
X-Gm-Gg: ASbGncsn59m0dMo+khuGGQ3vJmAVjWHtkpsKXjblH2vE1WM3AknHPMK80zAZsYOdT/K
	oSNuzNaNiq/l30TPsDWnsWDm9upUZkap4a3mr3BIxDfVhrLiFVf53h5HpPLI5qkWV/Nvjjl9kFp
	ElLiwqacMx1QAq8o6Tc606H9CydK75zX6oeqhqJvNvFVfyV50v24qAsu16VAYZGSjJjJVpojtpo
	pcZdBaV4HpdQvbjfrwGC9hTxINHWN3SYb2jbOqGuFz4flCrBodBln3nvJ+mZH6X1eydz4f8pblE
	iiImZV4Vly4hJc0qr9dcZ4h9kpINHTrp7YABfnJXEZ/2SYc+e0aELJAL7iKYclaQ5Zm4rItn3tQ
	7J7/8bsmrg1c1Hk8n5YreqWn/Yef3PmQ8/wyPOCXXlnLXRHrlphDSrJOLhEVbwwqmxhq5+AaFz1
	oAMtrkqaPat1Jggouk77/qmIA=
X-Received: by 2002:a05:620a:7101:b0:8b2:eea5:32f6 with SMTP id af79cd13be357-8b6a23fc290mr198021885a.1.1764987750607;
        Fri, 05 Dec 2025 18:22:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg7qoqx8dPOM63N9vdyRhip5Rkt0Kvl+nHluFypu1pM7HQ3EELlVQnZ+r5zO9ePfWE9JJxuw==
X-Received: by 2002:a05:620a:7101:b0:8b2:eea5:32f6 with SMTP id af79cd13be357-8b6a23fc290mr198019685a.1.1764987750093;
        Fri, 05 Dec 2025 18:22:30 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7c1e32esm2023034e87.53.2025.12.05.18.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 18:22:28 -0800 (PST)
Date: Sat, 6 Dec 2025 04:22:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
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
Subject: Re: [PATCH V8 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <vzoyeyhzrmvkhjeif6yuyxjc4moq6yzc5zuz7izeipz27f6cd4@csaqkjur3r3r>
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
 <20251127134036.209905-4-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127134036.209905-4-jishnu.prakash@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: EuhVLH_IsmJIiBonkbJtXlPkPGz9cHqw
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69339367 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=NMgD5LmOGRMCO4pDIP8A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNyBTYWx0ZWRfXwVHLPh9nRWfk
 YaV0Va7RnQBHP+DDccNUmQtriK8Dma49bJ7FWy6RkGhs80ODgjNIy6VEywbetjzuMWEKMPQs3pz
 UOQOLO/gbDvaRbd7lNAXvQRrC4XM0+L0KqCCcrCqFxeBSQ6TP39R8icwg/1K18/9bo3sf+2jgtA
 lcpJFdkwm4SxWAK7SKgDuZDZrpAYh8UBSxoKW6lnmaLbN73KJdJ1vXS+NnnH/XIRadf7P0IjTOp
 NMm2zbWxugrBKubMKQTDIXrZhTpUSnmGmDbuYBj5P/tEluXn3TsgE/26XwMAeRAESQy3iGoAkEZ
 xZamoaDdOfdncZMM9AN6b0HCIKFijEFM3XMFCG3njZq8VGOtYCzqr5s7wwuKxrzT52bJCgsqAhw
 uRHZEVGAChQBdPogRaywPv0ouXQd2g==
X-Proofpoint-GUID: EuhVLH_IsmJIiBonkbJtXlPkPGz9cHqw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_09,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512060017

On Thu, Nov 27, 2025 at 07:10:35PM +0530, Jishnu Prakash wrote:
> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS.
> 
> One major difference is that the register interface used here is that
> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
> There may be more than one SDAM used for ADC5 Gen3 and each has eight
> channels, which may be used for either immediate reads (same functionality
> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
> (same as ADC_TM functionality).
> 
> By convention, we reserve the first channel of the first SDAM for all
> immediate reads and use the remaining channels across all SDAMs for
> ADC_TM monitoring functionality.
> 
> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
> ADC_TM is implemented as an auxiliary thermal driver under this ADC
> driver.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
> Changes since v7:
> - Addressed following comments from Jonathan:
>   - Included regmap header file in drivers/iio/adc/qcom-adc5-gen3-common.c.
>   - Increased comment wrap length in adc5_gen3_configure() and 
>     struct adc5_chip definition.
>   - Updated error checks in adc5_gen3_isr() to remove NULL check for
>     adrv_tm and keep (!adrv_tm->tm_event_notify) error check alone
> 	within if() condition.
>   - Removed sid initialization in adc5_gen3_get_fw_channel_data()
> - Added definitions for ADC channel macros used in adc5_gen3_chans_pmic[]
>   in include/linux/iio/adc/qcom-adc5-gen3-common.h instead of 
>   include/dt-bindings/iio/adc/qcom,spmi-vadc.h, as this latter file
>   will be moved out of bindings folder in a separate change. Also
>   removed its inclusion in drivers/iio/adc/qcom-spmi-adc5-gen3.c.
> - Cleaned up local variable declarations in adc5_gen3_isr() and
>   adc5_gen3_get_fw_channel_data() and added local variable for
>   adc->dev in adc5_get_fw_data().
> - Fixed error message after platform_get_irq() call in adc5_gen3_probe()
>   to print IRQ number correctly.
> - Added a check in adc5_gen3_get_fw_channel_data() to exit with error
>   if ADC channel value obtained from `reg` channel property is not
>   among the supported ones in the array adc5_gen3_chans_pmic[].
> - Corrected the value used in checking for max valid ADC channel value,
>   in adc5_gen3_get_fw_channel_data().
> 
> Changes since v6:
> - Addressed following comments from Jonathan:
>   - Moved functions exported in drivers/iio/adc/qcom-adc5-gen3-common.c
>     into namespace "QCOM_SPMI_ADC5_GEN3".
>   - Increased line wrap length for comments.
>   - Added local variable for adc->dev in adc5_gen3_isr().
>   - Shifted debug print showing IRQ status registers in adc5_gen3_isr()
>     to before tm_status[] check.
>   - Fixed indentation and brackets in adc5_gen3_get_fw_channel_data().
>   - Cleaned up array formatting in adc5_gen3_data_pmic struct.
>   - Used scoped variant of device_for_each_child_node() in adc5_get_fw_data().
>   - Updated auxiliary device cleanup handling to fix memory freeing
>     issues, by adding empty auxiliary device release function.
>   - Used devm_mutex_init() in adc5_gen3_probe().
>   - Updated virtual channel macro name from V_CHAN to ADC5_GEN3_V_CHAN.
>   - Set IIO device name to "spmi-adc5-gen3".
> - Added __acquires and __releases macros for exported mutex lock
>   and unlock functions in drivers/iio/adc/qcom-spmi-adc5-gen3.c.
> - Added error check to fail probe in case adding auxiliary TM device fails.
> - Replaced 2025 copyright in newly added files with yearless copyright,
>   following new internal guidelines.
> 
> Changes since v5:
> - Addressed following comments from Jonathan:
>   - Corrected line wrap length in Kconfig and driver files.
>   - Replaced usleep_range() with fsleep() in adc5_gen3_poll_wait_hs()
>   - Corrected all files to follow kernel-doc formatting fully.
>   - Removed IIO_CHAN_INFO_RAW case in adc5_gen3_read_raw()
>   - Cleaned up formatting in adc5_gen3_data_pmic struct and in other
>     struct definitions.
>   - Updated adc5_gen3_add_aux_tm_device() to keep errors alone out of line.
>   - Split mutex function exported to ADC_TM driver into separate functions
>     for acquiring and releasing mutex.
>   - Removed num_sdams member from struct adc5_chip.
>   - Fixed dev_err_probe() print in adc5_gen3_probe().
>   - Updated logic for acquiring IRQ numbers to account for removing
>     "interrupt-names" DT property.
> - Included bitfield.h header file in drivers/iio/adc/qcom-adc5-gen3-common.c
>   to fix kernel bot error.
> 
> Changes since v4:
> - Moved out common funtions from newly added .h file into a separate .c
>   file to avoid duplicating them and updated interrupt name, as suggested
>   by Krzysztof. Updated namespace export symbol statement to have a string
>   as second argument to follow framework change.
> 
> Changes since v3:
> - Split out TM functionality into auxiliary driver in separate patch and
>   added required changes in main driver, as suggested by Dmitry.
> - Addressed other reviewer comments in main driver patch. 
> 
> Changes since v1:
> - Removed datashet_name usage and implemented read_label() function
> - In probe, updated channel property in iio_chan_spec from individual
>   channel to virtual channel and set indexed property to 1, due to the
>   above change.
> - Updated order of checks in ISR
> - Removed the driver remove callback and replaced with callbacks in a
>   devm_add_action call in probe.
> - Addressed other comments from reviewers.
> 
>  drivers/iio/adc/Kconfig                       |  30 +
>  drivers/iio/adc/Makefile                      |   2 +
>  drivers/iio/adc/qcom-adc5-gen3-common.c       | 107 +++
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 767 ++++++++++++++++++
>  include/linux/iio/adc/qcom-adc5-gen3-common.h | 216 +++++
>  5 files changed, 1122 insertions(+)
>  create mode 100644 drivers/iio/adc/qcom-adc5-gen3-common.c
>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
>  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 58a14e6833f6..da201a9a6950 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1319,6 +1319,36 @@ config QCOM_SPMI_ADC5
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called qcom-spmi-adc5.
>  
> +config QCOM_ADC5_GEN3_COMMON
> +	tristate

This Kconfig (and the module) are used only by QCOM_SPMI_ADC5_GEN3. Why
do you need to separate them? Your thermal module doesn't depend on the
common functions.

> +
> +config QCOM_SPMI_ADC5_GEN3
> +	tristate "Qualcomm Technologies Inc. SPMI PMIC5 GEN3 ADC"
> +	depends on SPMI && THERMAL
> +	select REGMAP_SPMI
> +	select QCOM_VADC_COMMON
> +	select QCOM_ADC5_GEN3_COMMON
> +	select AUXILIARY_BUS
> +	help
> 

-- 
With best wishes
Dmitry

