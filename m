Return-Path: <linux-iio+bounces-21872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3047BB0D7F1
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 13:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EAD4164879
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CFE28C5B4;
	Tue, 22 Jul 2025 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kuDjK8lV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51828981C
	for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182728; cv=none; b=qyj6V4IYsWSCxw7KbSS1oWO+ChAKDUyklEdanzPEuy8h5/eTw9djiGf0z6NZpsP/7Mc2LliSDC98Z48WHLtJ6uz+It/SkwB04IYLcNKHdjJqYF+iPAa0z2vdLpRCraZxydxLTDPDXUWnEPkfDo+pTaA0/sk6k8UtXaYuiVLEkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182728; c=relaxed/simple;
	bh=AdS/HEGQYIwXAPgGKh/dj7/4HJqP4YWiQMnvmpzNaGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBNujKx4roZcdruEShuXL86POozcDvskMB6pXWK1geSu7nJkHSTKdc1HTLR1yg08Qf5da6JVNSAtZNMS7V0B1vMcFcHSSoEecuu/Cn0P1s4CnpGjw1HVUWqUlQKjx2WqlP76vuW6TDagnNb9+vr6HcMhSiCDGqnM4GOXCpTIRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kuDjK8lV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M3VXgE016585
	for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 11:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lp9oCAfC0uqs28+yLNSlWvHOEvpNJYHHvb1kBs8yoFw=; b=kuDjK8lVrMQ29mM2
	NnvkBJtssHyZ940GjxnoRNMKZIaxrrUx8OXjNq0M/7BtxrF5bJvbBeYk6ggjByLo
	PwzeE6UzPYbeH2HjAjXIWWUlV2lGbdSN2XiTlUTL9IgR/r9Zn7QKGAkBaD9K5lyN
	RIKWxENkALQGIO+ipEuOmfCiHWx3pFg+M73KWyqTq/Rz26jIV2vpsG6lgUxrkti2
	Lh3UHvoSbhksgHnFKlfDBWl+tzn/5QD0hSvpBlrkZIXA2MLcqD25MBwTkjLj/obA
	SmTVTcuY9IMCN16lD/Tackv2Syvpf+s7q0WFRV6BqDaEkCr62XhpKPUTbzRoxzuf
	HnrRrQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s195b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 11:12:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7deca3ef277so11257185a.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 04:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753182724; x=1753787524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp9oCAfC0uqs28+yLNSlWvHOEvpNJYHHvb1kBs8yoFw=;
        b=Q6Lg32neZeCsQK/BwiZyxXqBkh5WWxpUVFu9Izh58W1+nJTG4G2H4UAbCA9reVpUxv
         gyq/NnNN9urBPxtxU80m5dPk2icb4+km0sOVqCLtXx2T25QTtQJYHBdgEa0qjJa03lvJ
         k4o4Dv65SmqFGBa+G993qNkrJOGKQxo1bvzrht04Thzw0TzZG46aUvnSt3Oh9FsYjHiJ
         3hrP8WOoTTTr5wwCqNtGXf5aRbChxbFqXda9oJYeFIXddzosWWgbnnFzrMNkowSww5EX
         fqq2Ad5A2GOFXkb1qSOsBhn/RzQF23mvqbEbxkxPrkRdhgx9FPRsKfgcFvFhtN1MSxXT
         Dw8A==
X-Forwarded-Encrypted: i=1; AJvYcCUNVwSb4E1KiHA4CPIJu1YLY9Ft22ZCf7bHkwj+x4aBCFCxY+noLhLummoq9jo4CbEmNxuo/8DRU2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlFRQRWhd9dvRazCZQT8hJbXBDxPASVk6gkPN15OxQ6HnuWo/
	cj7hn//n3jS6roJpm7qflub2g+RM83e25nT8bVmwpv6DU5+CMuIp1uiDKDwqPU6eRBzyTi2eLLr
	27FMC8swNLxNkbgFE81SXNb8W/BddiGVc31ECW9yIPeNl2TDYrJh5An8fR4Q70Wg=
X-Gm-Gg: ASbGncuEOAqlS29G4keypqeddo7eH8Y0kiDdsDSHlYBCQkl/B246myU4Z00oKXahS0u
	zgmbG4semTNFByRWXOUMeYs5yVME+JlBfZL3ybF+mq/cLDkFE7OWT/Ci2gN61E1t9TYr/fe/Xcs
	fl4s/Ybot3bMBipGUNqXvCEdu3CewACV6I+wcREFX3mC9Yft94v8bpojoBQmAJblpMGkys8lGjp
	1BNQQdF5wdUddW78DwnOt44JzDpMj6Q/WBUt3p1hXkcWnfJ9VEh4/4EJ7vxRq5x8IiAJtYMMGFI
	FNwVuK9QmI7GOa5TJfyNtFiUgwhpnLKT0rqKCe9vlxiuaF8CDpAtbFLAxBxUVz0OBBSChQyjbZz
	UTg3agasux57+ldg350L4
X-Received: by 2002:a05:620a:4894:b0:7e3:2c3a:aac5 with SMTP id af79cd13be357-7e342b70ea4mr1315162385a.12.1753182724458;
        Tue, 22 Jul 2025 04:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsVndy6GfF1/rbOfATVToveGOqPm5CxByBr7sl2oaOgD0x8vxoWl1Wqyb/DMzWWuenDTrgHg==
X-Received: by 2002:a05:620a:4894:b0:7e3:2c3a:aac5 with SMTP id af79cd13be357-7e342b70ea4mr1315159785a.12.1753182723749;
        Tue, 22 Jul 2025 04:12:03 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f36f96sm6863713a12.23.2025.07.22.04.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 04:12:02 -0700 (PDT)
Message-ID: <41dda9bd-12c8-485a-a6d0-69d040d724cd@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 13:11:59 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        sboyd@kernel.org
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
        andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org,
        krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
        casey.connolly@linaro.org
References: <20250722101317.76729-1-angelogioacchino.delregno@collabora.com>
 <20250722101317.76729-3-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250722101317.76729-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5MSBTYWx0ZWRfX4Tn5ErJ1KqZU
 RbWHhfwgKyNn7uVr7mlu4qZ2V+JJt5iS8ce47h4bdwPoGW0Xb7CeIkQcnsjXcIxiR8FWd33es58
 AZdoeb250637D4RhSEtY2n9N8M3hvk0bTacpHp3zF3I3ndPd/SxUxXmiYHV5I+RsYOP31O6qIKL
 7kFl67AhnCrsRYan5WzuV0e2B5Cr0brqbVtGO/sKcjDHNulLI+6t0iufegPQ8pSFD0fsQLVbXak
 SfamKtfo6M5ErXYhP/n+208LX/XIP80Jn2zf4r5Y4xolR+xqECudVpot9KpCq44casA72bNMRgn
 y7yNWdA3LibLItwJQBALChA9h6ZeXUBmihzoViCWSX+Uh0sItFr7RbnH1HC+8P0fBX5GIQ5nV97
 yTerrFWCVlpLGvlyTmZZws7cn6HEcsHKgV9mlD4l+Co528MTuFJvyaL2oki6e37iMy4JtZsb
X-Proofpoint-ORIG-GUID: HE_bqsOxTt26WpZiNNOy10_Xbew9IifR
X-Proofpoint-GUID: HE_bqsOxTt26WpZiNNOy10_Xbew9IifR
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687f7205 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=Y_nGuXgBD960inqFf4MA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=754 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220091

On 7/22/25 12:13 PM, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrate a SDAM device, internally located in
> a specific address range reachable through SPMI communication.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device for SDAM
> and initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

