Return-Path: <linux-iio+bounces-26671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E1CC9EEB6
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 12:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE583A6EF3
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC442F658A;
	Wed,  3 Dec 2025 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="AhwgpTq8"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023134.outbound.protection.outlook.com [40.107.162.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335752F60DA;
	Wed,  3 Dec 2025 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764763080; cv=fail; b=LqaiYrQdSO1OfEt016i659wb644ix+FPEIeaM4HW4L9w+8hTrvnUA1NANO6c9vdPJs62PTWBQ+0pO9M9gxQkbHyCSWPaPE4LOAIe6qENL6f+WDVS2FQa6xCcDW4G8cNx9xCfiPjg1T1et2v+kuePuSXddm/Agm6ZMectIseiCOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764763080; c=relaxed/simple;
	bh=O3QSqD7W5yonw+4YNuCwRwwmlXK/TQ4p1zOEKsNdMbo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OkRGe6n9I+/0frz0WV5W/3phZdO6WiZ23nh06IwNhT6WCGzCWtoeHnXk3wXrxiAvm/SSMxH97GIUK9Vl2YSU9wRCKFKqrLYK+u4ecGLyNMjzij1L39+XiOkU3s3l6ZVb9D0/lgPCteX9ph88yE5Hr8ga2pWJpK2XT2yX44GfWoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=AhwgpTq8; arc=fail smtp.client-ip=40.107.162.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OP78LyvP5uAUHTXnV1CIyOelDJgYti5lCmYh3/DY48q1xACk6nHQK47he7hpLyUlkhUJT/RJ5ACZHGsBenL4PKX4k6eWQwHghNY1UhpwQuUZgV+G/Z/tzMEo1z4Y3MGn7QKn1XZyKNAkJrrrAYo6BQ64Z21cKQpDuKac4jLgXKG5n9f1fZ4URmzyc+w9tLOirJCnfkv1XIVPRv7dccs38sls97sBfMBwwP8svgVVZxGPl0ASOdg9gzMJvKsQG/9RyJ/o6olWRri5puU40xbnT5hIe6KTNCwBkgFuMmyTYGJueVqfMI7/VVPNCcCYwpDCNJck6Ng50S3Rxh9ON/r1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhc/kaqg7/82LvePuB2ooFffiO+6lvzN3/uSWbuAvh4=;
 b=Xw9T67Po/pJzdIwE6FrVQvNP3tZe1vXrsQTvfLd7v8sAM/6BFa0Al73K1G+6gktXsV0d3H5HPzWEaWSRQO0y4Hq6/KrfpfFIgT/Co0y11jmJcS7aLT/dBvHh2mfzd/rzW4rlgbvfKXm2NcFGqOhkre37iRm4SXD5qPXGysOP+YNzhRRiUzZTaUvGoOg3t4cfXaJA1MKAHIoWePBgLzaekoZU8uHx/Mptqaq3JBiu4ENU11h75gLLY4gE5AWPIxz5O2LG2ypIil6S8Sdkvr+eXEKT0bcHes+9MTgGQsu3oBa+6VPjq9F1uS2lAlTdc38dbsz4GnY+qz2ttdlA+BYk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhc/kaqg7/82LvePuB2ooFffiO+6lvzN3/uSWbuAvh4=;
 b=AhwgpTq8GNr7FofGrY+sM3OOOo+/gmgkeuY0b0EYnEo0uAqWKSVZPy5pKS5a6Ao4bAJ+ZWTwcYIppzlgXAHYYAWb3MMnCcL5etlPNpi0iybe6OtXoih5IQcuyiGvEBk1OBaF6P30D76kGWuFIGXUnqNain1tMbAgIIZ1vIZph3HKZp1PJssnhX67li1N9dASI2ReBzm1PbmmsB8qB3JeQn7F5xwWZh26NTwzWgz/A0zIdU9nfjdJyjY6PNc4XrI0vKYBq1xQjh7bS+u6emGchLffUgl2dp9+tMB98qPz5dPrOctSx3DqDJXGY9uSDatjEXgWxbkMaDEnC4ypDYxP8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PAXPR06MB8047.eurprd06.prod.outlook.com (2603:10a6:102:1a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 11:57:52 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 11:57:52 +0000
Message-ID: <19d5c51d-41f3-446a-aced-5be2fe6ec0d2@vaisala.com>
Date: Wed, 3 Dec 2025 13:57:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] Docs: iio: Add AD4134
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 marcelo.schmitt1@gmail.com
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
 <69b230190abb4cd76ad9eb25e2bde51caaa23d9a.1764708608.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <69b230190abb4cd76ad9eb25e2bde51caaa23d9a.1764708608.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0049.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::7) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PAXPR06MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f75376-e751-4e20-6632-08de32632fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmtxUk1pbDkvRDdkYnEySnk5RXNxSi9YZnJIUUpCd2M5SVZvV3BGSHR5bWdy?=
 =?utf-8?B?Q1ByZXFyVFAyTGdSdW9rL3cweDhVUWozSTZTcnorZW9qd3AvUTl4bUdnSUpw?=
 =?utf-8?B?MkYwSUdPM2QxTmY2MGI1bThiZFFJZkxNOXVVMWw3K3B6dzJwelg0VEFFUGlh?=
 =?utf-8?B?U00xMGl6a2lkRXJhMWNteUVPUTI2aVdqaWo3WHdoQ052cG83S2VoaUhIMHF4?=
 =?utf-8?B?b0ZCQVFISUFHSUxRWjI5bSszNEdWQlIxVFVhZm9BQjNWVXN5UjFGcFExajFy?=
 =?utf-8?B?R0hTWlByTnNaLzVOcERDek9ueENubWhrbFFWQ0ZldG85RjlOcTkvYmdKVGZh?=
 =?utf-8?B?dUkvWUNSN1J3aTVIUGE2ZFhVczFtZE1aZUVjQm5DNWFRYzRscmR3RlgwRFk0?=
 =?utf-8?B?c25RMWdoMDZieVVYQlpwTkRvVXlvcU05a3p4OW5VL0plNmtxZUVYcjk3dnh3?=
 =?utf-8?B?UzNDUXJXQmNmVktoVzJQRXJPTnQ2Y3U1QWlpU3pPeklqcmxZYldHTHhSYlRW?=
 =?utf-8?B?NUg2Wk1KQVp1STVlTHBZdWhvRjdWcStkWlJmSmg5TzB2L09yOGRFeXBhUG5m?=
 =?utf-8?B?V2tpdnlpL01DdjdmS2JXU29jNExHR0ZQMjY3OGk3VTZSb0xsKzRFR0t4ZEhW?=
 =?utf-8?B?aWt5QlV0MkxJcnFtaW5xZWg0RVJxVUFZS29YOC9uc0dBZW0vQVJXTGZRcTMx?=
 =?utf-8?B?RW44eDNFZ242SHdjL1NEUjBONUFWTVpEZUFxRHlOL2R3M3k3dnBzQS9BODBM?=
 =?utf-8?B?bndPajc0U3lIZXBhNDdMUmJ3YlBKQzRFZnJxTTZiaVJLT2MrV2p2N0hnU0xF?=
 =?utf-8?B?dm9sSDJuSHlQZkZaMGNIVzBxUGdQbkpkQktqTmRmcUdqVEdjd29hRWt4WHAz?=
 =?utf-8?B?R0hPMnZlSlQ5cGRCMnBOVkxrTm11b0NjZ1Z5RVhaSElHeSt2akVyZEd2Tmkw?=
 =?utf-8?B?cVVoaHpRL04wSEZlUXdua1VnTHVXOUFVNDFMS0dPbTE2UEF0ekhnYzFvMHI2?=
 =?utf-8?B?THQ1SnFnSi80QUJaTlZPZ1NIUzBNTGYrUzlaeHdyMlJRN0k4bGVIVXF0NHBW?=
 =?utf-8?B?Mys5bGJuNkZLYUNaV0hUdTU1ZVYxMUFQTlNOUGVNK2lSNFhUQjFnMjhPNG4w?=
 =?utf-8?B?M0pPRUJIT3ZZV1dzcXpTTzY1RGdOTVorNHY5WGRCdjJMS21Ec3RtTWdxOWxi?=
 =?utf-8?B?QWRwOEt5YmU3TU8yYzJpckZzVU9rdEw1NFdEK2trTjNOQ0ZwbVpySGtJSldx?=
 =?utf-8?B?b2ZGenoxOHh0Z0JRdFhOVDBSWld6OWJ0ZW53TkdFRnk2WEJxYklVd3NxM09n?=
 =?utf-8?B?WlJnUlBxWlBqcFRxaW9iTlczMEVnRzlOV0hjWlQ5Qm9EWGdJZHZ1WVYxSksy?=
 =?utf-8?B?S21lcnFUVzY5dDBqRVpxbDEyaWZ1K25Qd2IxaDNKL2oyT2M4R1lkYnptaUJq?=
 =?utf-8?B?QlB1RlBZdUNxVy9PVktkblVva2NYUEJIVzhJcThDblQzZFMycDZuSXJEQ2RL?=
 =?utf-8?B?RS9xSHdVUDR0cnV3UkhOanlvemRQNW5DTjFHajhSNlhMNEQ0L083eEdLckZa?=
 =?utf-8?B?ZnJZL2JNSTR2alphL0RPenozbzY2NEQzQW1IbVlHZjJhYlNuQjE1c3pwRFhu?=
 =?utf-8?B?dnJUanZyWmZuU1A4YVpVNUVsby9sa0dNTEpXRkZhQm1CN1VkUENIclM5MGs2?=
 =?utf-8?B?RWlaTkZKVEtpazl5V0J5bGd3QWJ4dGNaR0lpR0RkQ3lvdmtOQnNvaHdwdmVz?=
 =?utf-8?B?Y2hmUHpFSlljbXpuQmxSd3MvYkI1alRCeWxtY2NMWTNiYWxjeER2d09GREVl?=
 =?utf-8?B?ejNIS2NHcGxpbVF5UHp0RU5YWXlXMFFGTDJwRlhLUElOUmFGWVEyUTJGUFZ2?=
 =?utf-8?B?NGowY1NVRWFWUFRydUxpSlZpcjN0dDN2ZkJKV0xYSHhMMmI3OGhHSlpOTVdv?=
 =?utf-8?B?WFgrd2lWRkRxcmxaSGJQUzVPaU5jOW84UjIxNXltOTZkb3hJMzF6NVFQc05X?=
 =?utf-8?B?Vm5xN2tSREh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWxRZDRML3p1dktBbWZhRUtFTHJ1V3cyaVBlblpDamtRNGNIWmdCaVJhb09x?=
 =?utf-8?B?N1JqMk9WWHYxa2hIT0hsM3YyRmx3K0lIVTFjREJ5UGpRdUVXTW5Dc3dkYjNz?=
 =?utf-8?B?NG85UzJxYU1RRTFaOThsVXlGTHJNU1Urb3RzdzZRSUhENW5iNmwwSGdTNWVi?=
 =?utf-8?B?RWVzNlc3bmtOMzhNcmNQK0hoOVpPU1ROc0FwYllpa05NRFQxTFkvV1F1MWM5?=
 =?utf-8?B?NmNzU3JmVmdNVDZtUzNVcHdadEt0a3g2L1pkOVJGMFVZVzQ5dEJlZjB5S0dT?=
 =?utf-8?B?dkVDY2lVbXlJVzFQaXlyU3FVOGx4em9xZC9hU1RmTURSamdFRjVXRTY0Mllz?=
 =?utf-8?B?TUlYRWkxMDJpc0NNblZ0TnF5eVljdGptcDU3MVp0YktkWEN0U3kzNnYxZDlO?=
 =?utf-8?B?aUxpbGRvSmwzS3lqTlBVSFIrRHVYS1hDNTd3YjllMFhUOG9Kd2MrOThNSS9y?=
 =?utf-8?B?U3FjeW9TODlsMTkyWEphNDRHcDBBd2g1RTZJWUYzZDRiUlJrcXhzbHAxakgv?=
 =?utf-8?B?dUlId2s3M3Q5ckRLTzFLTElKZEdTS3FJTHFwNnlrem85L3VGZElhRlJCWUFO?=
 =?utf-8?B?Wk9CZGhZeFZVR3h2RXFobUtJbkxkRkdDNkd2TUV1RHpmRWtrNDV6L0VYUnBi?=
 =?utf-8?B?WllCRDJBMHlTZDlyQlR3WFVXNld2eEl6a2lzZmFPWmxnanRWYzU0eCtZU3JO?=
 =?utf-8?B?MCtzOEFCMEJmc3pJTDg5N1JYMTFCMG5DTEpYWVg0aEFFTGZ5TVU5U1RYVDNn?=
 =?utf-8?B?R0FkN2poZFdoeWltZmhCTUcrck16cmVmMTJlR1Q3ck44VE1SdFJ3RjR2a3Ex?=
 =?utf-8?B?cVg1MGp6eWp2ZWJlNklFclZwdmtxcHFqNHVwd21iMk1JbXoxQjZYemN5Vi8y?=
 =?utf-8?B?QW4yZEF2c0tpWGNTRFdzTDkrRzhtaHRCcExOeVRjcU9WU05CNUlMbGJocHVt?=
 =?utf-8?B?UHFVc1VDYkJBTjNLZ2tUQlM2L0hVV3VxeHdyMFYxaVF4bTdIU0UzeFJaeWVZ?=
 =?utf-8?B?RFVIRzJBYnZVa0Y4ZWcxeXE4STBoaXpNU0Q0NDdyY1lqdWNVbHJVd2hhL1hn?=
 =?utf-8?B?aU1FOEtvNktzTHMyYU5vcXlUNEJtMEJLTE50NHhxYTNxNlp4WCtRKzMweWhx?=
 =?utf-8?B?Y1hmMnBxNXFZRVh0Nm5wbUs2bDBCR0dqVWZaK2UraTJBYWR3V0VESjNRbVFo?=
 =?utf-8?B?N3hKU3BybzI3bmpvYlZ3VEhoY3NOZHBXd0FKRHQ1aWdjcytuN29xNE9TV1hC?=
 =?utf-8?B?dmxxc1NCVmx2ZDFNNWRhc0NTYTZ3OHA2cUViQ1JycnQ4OUpWYUtJaytiOEZO?=
 =?utf-8?B?UHNVYjV5QndueE5RN3lpZ01yNHpTSDI0OXVRQUU1QTNYQksvVGF1MnF1ZG1X?=
 =?utf-8?B?UkxoU05rYkZwUG1rN1ZWRGo3cVFiMWFXSVBOSDQrbVVIbVZpSWVNMG5HWWo3?=
 =?utf-8?B?QXM4U3J6T0Fsa0xCdTFjVXVQQTRGNjF5RWhiUFlNdFAvekhleTViY3Bnc1hR?=
 =?utf-8?B?ZC9JbWlVbUswN05Ua2kzeDBqLzVZTkt3STdLOGoydjVRLzVhaW5ZeXEraFVm?=
 =?utf-8?B?MjBwSmpqZFVBVDllS0cyUGRxS1lGSFJTMU5MZERXOXVoWGQyeU94REZ3dFlE?=
 =?utf-8?B?SWdrZVNqWUN4dkFNeSszMjY2SkorSGEzV2E0VG1WRWdSazVCaHdwY1A2b1hC?=
 =?utf-8?B?KzZnVUYvc1RHYkJvZjUyZ083ZlJ0U0E2L1J1WENFMFZpQUZGMGhPajhjdmdy?=
 =?utf-8?B?YUk5MFY0eitSZzRLR2tLT01NQ3owM2w1eE5EUktDVVY0Q0MwR2doM2NKTEJp?=
 =?utf-8?B?MXVDM2VPK0pUK3B0dG9QR1Z1aWY1bjVqaTFUNzlyU1ZqVHIzM0pCd0NNZXFL?=
 =?utf-8?B?YUFmYStITzB6V1BzMWZlRGxjV01sb29oMStFNzNlYTg2MElsL2trSk1TS29n?=
 =?utf-8?B?bmlubXJMKzZ0RVpXNWY3dU5EZTQyRjhEZk8zVGQydzU0OEowY0Q5c2c2ekZk?=
 =?utf-8?B?cjROODlSdzJUTUZFSzRLcHlIbEgwR09GRDh6SVhsNENPSG1nR2dZVEh3bDBh?=
 =?utf-8?B?aitPQlNqSklQbVl6cjBJQXpqMGpTQUR2azdjNEU0RFdTaVlpaUNQbFJXZHMv?=
 =?utf-8?B?K1NGUnl6MEFNWUhMb0NKWEFzbmdpeVdKaldPTjluNG5ZRTR6OW1IalZXb1o2?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f75376-e751-4e20-6632-08de32632fe6
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 11:57:52.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6Vjl2K4fjLcrphYurCGSx0O5CmWVMuj+v9yRglArjnIO0JWGULYT1vY0ekNVN/9BnfcjnZHyLKgjKy9Fa575Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8047

Hi,

On 02/12/2025 22:55, Marcelo Schmitt wrote:
> Add initial documentation for the ad4134 IIO driver.

I wonder is there some information in here that is not readily available
in the device datasheet? After all, isn't idea with this file to
document peculiarities that are not easily found elsewhere?

Thanks,
Tomas


> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> No changes from v2 to v3.
> 
>  Documentation/iio/ad4134.rst | 58 ++++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |  1 +
>  MAINTAINERS                  |  1 +
>  3 files changed, 60 insertions(+)
>  create mode 100644 Documentation/iio/ad4134.rst
> 
> diff --git a/Documentation/iio/ad4134.rst b/Documentation/iio/ad4134.rst
> new file mode 100644
> index 000000000000..fa44a05e6793
> --- /dev/null
> +++ b/Documentation/iio/ad4134.rst
> @@ -0,0 +1,58 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD4134 driver
> +=============
> +
> +Device driver for Analog Devices Inc. AD4134 and similar ADCs.
> +
> +Supported devices
> +=================
> +
> +* `AD4134 <https://www.analog.com/AD4134>`_
> +* `AD7134 <https://www.analog.com/AD7134>`_
> +
> +Wiring connections
> +------------------
> +
> +AD4134 and similar ADCs can operate in a few different wiring configurations.
> +
> +Minimum I/O mode (SPI control mode)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The minimum I/O mode wiring allows AD4134 register and data access with the
> +conventional set of SPI bus lines. The hardware configuration settings for using
> +AD4134 in minimum I/O mode are:
> +
> ++----------------------------+----------------------+--------------------+
> +| Pin Function               |         Level        | Description        |
> ++============================+======================+====================+
> +| PIN/SPI                    |         High         | SPI control mode   |
> ++----------------------------+----------------------+--------------------+
> +| MODE                       |         Low          | ASRC slave mode    |
> ++----------------------------+----------------------+--------------------+
> +| DCLKIO                     |         Low          | DCLK input         |
> ++----------------------------+----------------------+--------------------+
> +| DCLKMODE                   |         Low          | Gated DCLK         |
> ++----------------------------+----------------------+--------------------+
> +
> +A possible connection schema that sets AD4134 digital interface for minimum I/O
> +mode is:
> +
> +::
> +
> +                                 IOVDD
> +      +------------------------+   |
> +      |                PIN/SPI |<--+     +-------------+
> +      |                        |         |     HOST    |
> +      |                   DCLK |<--+     |             |
> +      |           FORMAT1/SCLK |<--+---- | SCLK        |
> +      |   AD4134      DEC2/SDI |<--------| SDO         |
> +      |               DEC3/SDO |-------->| SDI         |
> +      |                    ODR |<--------| GPIO        |
> +      |             FORMAT0/CS |<--+     |             |
> +      |                   MODE |<--+     +-------------+
> +      |            DEC0/DCLKIO |<--+
> +      |          DEC1/DCLKMODE |<--+
> +      +------------------------+   |
> +                                  GND
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index 315ae37d6fd4..d4ed782c93a6 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -22,6 +22,7 @@ Industrial I/O Kernel Drivers
>     ad3552r
>     ad4000
>     ad4030
> +   ad4134
>     ad4695
>     ad7191
>     ad7380
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a1541cf3967b..b2c101598636 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1455,6 +1455,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> +F:	Documentation/iio/ad4134.rst
>  F:	drivers/iio/adc/ad4134.c
>  
>  ANALOG DEVICES INC AD4170-4 DRIVER


