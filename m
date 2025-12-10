Return-Path: <linux-iio+bounces-26998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 395C9CB445F
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 00:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 500AD301FA45
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 23:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F233030F815;
	Wed, 10 Dec 2025 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="iOfaxmgL"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020122.outbound.protection.outlook.com [52.101.84.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5930E827;
	Wed, 10 Dec 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765409408; cv=fail; b=hmSC4l6Yt6mp1fXUAqyBDMrtXDgUSW+DjgLc70bI+xp7CLfxebV2VzC1GjREn6SQ5Gah4B6nLronP8S+DTvfy+uPa5AvncAD93NAOjh2H70QMsFKcpVrt8DVtcJBIGbjsymMDIisPu3JE/hfk9kA2eh/LqsH8OuECDpWdq9k8tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765409408; c=relaxed/simple;
	bh=zk5OSuReTZAldWpmpm2nE5/MvDXf/6nKSj2aNqWLWeI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QBV0eth7xIWrM9SJRCN4hbF1CnuGhnJ2WOKM8JJtv8WmYx39RckMDSROi8Y2d0FLtnVBJPwRD7jj+5WhSbQPl00zqHZkLSbTbthSGk07vHf7G2H4xvS7gqyRnbVjir2m5e1q0xtL/9mwHwozsBQ4YfwgLo73AKfgyvajoTcPTgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=iOfaxmgL; arc=fail smtp.client-ip=52.101.84.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEQK57Sp7QrcFlhYh2+e7UqjZEKrT0w/IWKOrLCgSS7SsrstJyI2fRDKynAqLOGGsZ5SCxjlB0lyRNMzJ/sF2hgVOd8dTqYCeF2S5ymLVMWGio2a0AfR3QvCGUKxk27Wceeq4/lMMW2bAaFld53XqtDnZh/yMvAdKRMDctnle87rAC0pZkr0GzX++MSOAfYvcWigUTmkPU93tibfss7ijuBsWDPHCkL/SJ18cF6kZ3+P3MV0qtna46Seoh3Nl2D1A9Kgu+3Yoax3w0p27c/avBpx9fvdmuYpbBmDVYEdseozgs6UigIgZfrr10N3yDdT9S1sHQxQGQM1NP6JBOtutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcWCwZv7eo7//El2iVCMgoF703dwIMoCVLFXX+c4Y9A=;
 b=dfPvc1ayUZ889tskpe/uCqD4rJk4SPw3s7mJgeDV09nHEvITRRa/OIGPy+B47YuaKg4NENl1orRXlZSOjzP0JY5a83NNU4GiBJu32nunirwqHqyJRT+G3QvEioOxyKntSkCtekEd64vHrFVf/nmfEaRjO4076Zbigv+saWXi28T3b5gOIBpQZGx3EY2902xJfMKDBp4GDTsCSojLub6mYSpA2LGdHHZ8SPPqU+tyNcxEosbCSBWSwOkEIgJysNZ/ErwgHqeScND9cKjq8kjljN/8rGg2GiU0samgcYMtuKkVGvp3RFv/J5LeIgttq3NQbEZzmidnIcAdoDVoRNFxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcWCwZv7eo7//El2iVCMgoF703dwIMoCVLFXX+c4Y9A=;
 b=iOfaxmgLoR750i4lJV8Wr4ji9hXG9X5Fm6kB5dE3LKfcwXunvVPQf/gteQNjlTcca/QLKcrPeo4Sv2vwOsUhlhcst4AJhlyLlBFLVg21omLt2fH7QfNvLQGdQwA9jsVSvDFHCRoG2h2rPfFBgtNfaV1EARvxRz9kV77MI+4aLKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by DBAPR02MB6293.eurprd02.prod.outlook.com (2603:10a6:10:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 23:29:58 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%5]) with mapi id 15.20.9388.013; Wed, 10 Dec 2025
 23:29:58 +0000
Message-ID: <307296eb-e5b4-705b-6851-53cecb87a69c@axentia.se>
Date: Thu, 11 Dec 2025 00:29:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: lockdep splat involving iio-hwmon and iio-rescale drivers
Content-Language: sv-SE
From: Peter Rosin <peda@axentia.se>
To: Guenter Roeck <linux@roeck-us.net>, Rasmus Villemoes <ravi@prevas.dk>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <87qzt2tnlu.fsf@prevas.dk>
 <17697c17-753e-46a4-8e57-107dc744f18d@roeck-us.net>
 <ced7efb0-02eb-f1b0-9033-e546ca302f1d@axentia.se>
In-Reply-To: <ced7efb0-02eb-f1b0-9033-e546ca302f1d@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0001A329.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::693) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|DBAPR02MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8dcb67-f5c6-4095-760f-08de38440868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SU8raDN3dStvMHVmb0xHb24rQklWbTJQenBDdlhpRk9zeW9MN0EwTURRNFA3?=
 =?utf-8?B?ZDUycTFrclpDWmh1ZkxJNFJWaHhrMllSVGZET2N5TDRRRW5JY2dTUy9wNEUx?=
 =?utf-8?B?Vm44K00rcHh2VlpZM3IwS0xmZDR3QUROaHdNS2Frelp3UGtmUWtHQlJXbVE4?=
 =?utf-8?B?dStrekw4Qm5pOThENWxEU0c2T0N0d1pORlpZa3FlYUJ4MG12aCtUWmdMM2ZB?=
 =?utf-8?B?bkJHY0dRRGEyZGtnTW1PdFhzOEU1V0Y5Yk5rRFV4bjh0OWZncGxhelJJM0Zr?=
 =?utf-8?B?MTlEdzFyWHJGWjBWbTVRMVh6R1pieW9BTFExbjJ2M2dEVFVUYVhhTUxBMzVW?=
 =?utf-8?B?Vk4xemkxb3JzdkZCR01KVnByVm1FMkY1ZE5BeXg4MUF1ZFlBMUVSSDBnUnpz?=
 =?utf-8?B?NGZwbVNDZGtwRkN0M0VFTHpQVGgrWlpSbkdpcG9iaFRoYnptclJxeEdrNXNT?=
 =?utf-8?B?SkkwUW9TRnlaNGdhN3RlNC9UZmZGSkVOZEozams1dExudlpsYjNYQmhhaWFS?=
 =?utf-8?B?VEpxOEJMdWJFR0R5YXlkVmN3Mi80L1VHYVRZQnNMZWo3cmZ0QVlYaFFVTm8x?=
 =?utf-8?B?Y3U4OStQc2x2OCtTYk1hOVorSFUvbW8yaFVqTldvYjQxaFZ6THBEaGhKUklZ?=
 =?utf-8?B?SEpMWlJCa2lFR0NHRnF6NElxeFMyS2x0Ly9xWG5zR2J5aDZPWldQUXBlbzJw?=
 =?utf-8?B?YXBmUjRSczNHTjVEWGxSd05WNU5SOUwxeGpmMlR6YmVwOS9WTTVydW1qNXhQ?=
 =?utf-8?B?QVpvWkJWS0t4MUFDeG1QT0d4bWIrNlVWNjE0WHdMOVpGekQ5QUpDVzIwTnd5?=
 =?utf-8?B?U0RtS0ovTVYvd1YvR2pKY0F6WjhpNVluNy82QzVhRm5FZXpranQ3OVQ2WUQ4?=
 =?utf-8?B?dk5VZzJQbzRPVTFuSTVnMGlrU0kzM2VtcW9MM04vSGNjZDVxSGNaK0Q1dUlM?=
 =?utf-8?B?MTh0S0dNbk1DU1dFdTdKaWd5a1FvMlhxM0FaWkxRQmR6ZVc3SitjbFhlclUv?=
 =?utf-8?B?UWNCTHU5QXNoOGNIV25yNUNnSEF1NUJOTlY2cDZ5RUIzTjFOVEJRbDBvVlVo?=
 =?utf-8?B?cisyRENtZ040ZFlldXhXNldnTmlQVkFMeDJtcFBMeEJPL2Y1anA5OVdRd1Zy?=
 =?utf-8?B?S3ozR0doVnhqMmtvaVp0N091V09FNzN4aDhsVzRiRisxV3lGREZSSmtGQ1ps?=
 =?utf-8?B?Z0xBK1lYcU5mOWNnd3ZXd0tOd2htTHA2eE1rRTN1anowY3ZrckFtUkJacXpz?=
 =?utf-8?B?ajZOUFdkVk11VWxLdUpHWlZnZkRMV2pUOHdoQVpDOHMySWd2L2tpSXFYYWhl?=
 =?utf-8?B?Z3NwdGlieVVFS3U1SnRjd0cwSDBZanpyaGxEbW5KckJsNjdtb3BlZzFXM3dL?=
 =?utf-8?B?dW9iRjdMV2ZpNkYvdkl5ZkRma1J6Nnh3TTVGd2JKRDdiS2ZxS1Rrajh3V0pO?=
 =?utf-8?B?NUdYdGIxdDRhaFZWdUtkSEx4VWdlN3dCV0ZXRC8zNDlGRzVYWVh0UGF2Y1V1?=
 =?utf-8?B?eG9LZlA1cng1TGhQcHB0OVllSmh1TkIvUldybUdtcWp1ajRCNjRaUnM0VDJF?=
 =?utf-8?B?eXIxRDA0K3BZdEkwbW9ObXJ0eGlILzQveFA2REF0dXB1MEk4a3VlblIvWWJ0?=
 =?utf-8?B?aUdhU1d6RkhGUm5tSGIrVVNBbWVhamY0ZHhydmJWWEp6M1NWNS9TNmF0VTJ0?=
 =?utf-8?B?UzljMXJrckdibS9PQUJDc0xFRkN6dWk2c09FeFNab3R4UWE4Q3F3TDBDS2g4?=
 =?utf-8?B?UnpGT00xUXVFYjIrVEtXTFh1UWVMRjhIU3ZYY2YzVlczbGR3VmNWQkNzWWpJ?=
 =?utf-8?B?VEJST3RVN2x3eTUwanNxK1dUdXJQMGZoTWtYaWVXbDVLbytVVFRzMEZDa0xL?=
 =?utf-8?B?RjhrUnlLeU1SSWNCRnFRbjRpbThOR3VQSEZNa3FRbmVJWVV1UW5yNmpHd2Vz?=
 =?utf-8?Q?VBQySyeV3BLdXz7x9vGCBLDleiQTYpQ1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHFMRU4zTGZ3dkxkQjhKV3o3UEFMTi9sSjFBZGRGSEZvbGpEdmNJbmdnbEkz?=
 =?utf-8?B?Q0FzWm4yWUhjYStSSTNKWkk4SnhZYVdlNDB2V01MRkdGMVB5QWJOZGhJQ3ly?=
 =?utf-8?B?UkpsUVdoaHphQmU4dEFCOFo5V0QwdUJDZ05NU0lYVk5ib2ZYZjNmY3BEYk41?=
 =?utf-8?B?RElUQ1o2eldGV3RVLzA2alJWNkk1UEg1d3BRamdycmhFdEpqbERNaG9uOGlu?=
 =?utf-8?B?SlBwU3oxRDVLR1Q2UStXekx4QzF5NTR4VTFSVjJlTndLZnBpQ3E0dmo3Ujhx?=
 =?utf-8?B?YUJuSHNodHc1ZC9iQm1aTFM4WWJmUHhBajJtVHNBTDcyWWljai8rZEZ0L2JE?=
 =?utf-8?B?cytFZ2RxNFZpckxqdGlqZ3R1aVVaNE56ejhtWVRLWERVQVAxdzJEOHZsSlZh?=
 =?utf-8?B?bjFxb3hWZ0k5QWMyU0VDcUpWamRUSGh0d2ZZU2xUMGNmTklQR251V0liLy95?=
 =?utf-8?B?WTlMS3RpMTJVa0llczB3OGwzOVpQSmpiNGgwZ2FpT3FkNVpSbkI5eUtmTVV0?=
 =?utf-8?B?dkxJWmlMTmRlNTJrQis2MnVmRWMzWXA3L29SdjFYSngvZUVCaEE0MmpwTFNY?=
 =?utf-8?B?dzNhTGRMOXN4NDJXbzgvOTd5S050cmhET1M0VU16UEg2WlVJNkZ0T1Z5aENB?=
 =?utf-8?B?OC80dURRMjRwK0kwZGhXbEtHVkxLWE1QOG14dHJ5aFU1T1BTazMwV1I1SHRV?=
 =?utf-8?B?WSsxdWdaRmNmQm91RzdLTmVrUHhDbmVnZmROV0xHbUtCb3dDbEcxanFPVlR0?=
 =?utf-8?B?VjI3OGN6TkxkemY2ZzhaMFFyUGNPZEVCeFJxbnQzb1BxTVF2VHQ5djZpMGZj?=
 =?utf-8?B?MTNpSFEzOGNnbUYzTFB3bjNzb2REc3NWa2hxWUlCK2MrVWVwWHpENzRxeVVH?=
 =?utf-8?B?eE1oMkd5YzhrOExpdnorZWpwNy9LeTJSUnBVVUgxdmZ5Z0U1ajk4QTZaTWpF?=
 =?utf-8?B?Wk52M1UzTUw4Uk1zSkpkRCs5Y2tWbXZIQ2U2WkNpUFlkUkowelR4MndxSWpL?=
 =?utf-8?B?U3JNeXRydEViSE1kc2NtcjRNWDZwN0VtWEJVMEJGbXEwbnhRN1UzNkZ4bWRp?=
 =?utf-8?B?eG4wWmJIM2tiQzVmWkNMZlJZVTZzVFUvOU4yVndMZGNUWFhIb0VwVGhiQ2Ew?=
 =?utf-8?B?SXp2cC8xU3k1a3hteHdFcGcwMVJ4TEFxM0d0MWhudS9ZRnlxcktxcWIvMXdx?=
 =?utf-8?B?NVdObUVqWlIyY1NGeC9ONUZ1RmExc2FIMmFReDloY0tDcXU4NXc5UWNDUlFX?=
 =?utf-8?B?RXB2WGg5a21Hc0Y1Uk1PWU05UmJlUGwxa1FDMHkyK1NaRFU5OUl1WkNKSS81?=
 =?utf-8?B?aFZMbkF2R3p0MEVxR21kWHQzOUxUQ2RBOXNwV2xRTm5DQXUzYU1qQ2dudDZQ?=
 =?utf-8?B?ZEZUbGtHVUFHSCtzTVNlNlE0Z1ArVTlaV2lUcU9ab3djL0tHQ0JuSytNakJR?=
 =?utf-8?B?WWJ1NzFTSXJVUEtjYTJ3Z2FTVDhEbm80ZXdrSFlqQThaUVc0dFd3OWxKYU9S?=
 =?utf-8?B?TnFDVDZqQndKWHFsa0dva0JRZmk4UUdqNXZLVzBiNGN2b0IzV3dWMWxPMDNV?=
 =?utf-8?B?cVF4RHVVakJwd2dYNW9wcDgzUEJRRkErVXFFSDlVQXhUUmdEYjVESURaak1w?=
 =?utf-8?B?eUZ0YkFWQ2FtMGljUThnOGNtZDhTSVNUeERqc1FGb01vKzFiOWZpT2FhVEUy?=
 =?utf-8?B?T1ZlUTdtT2h5RUJ0SGZQaUZmTWtLZUJ2ZHpUVjBScWhGTkV5SlZTWmtXOTJZ?=
 =?utf-8?B?SWMyUU00TFRjRDFwbTNqNW9tajZKSjBVRDg5c0IxRW5qNWJoY1RmUjRtSU0v?=
 =?utf-8?B?RVBLRHRzUFJtQ2lnYkVpWUxtTmFTZU5zV28xZDFhY2czblFrWlB6YnNxcWRN?=
 =?utf-8?B?M3JXaEgwbW1FNVpCUzFpcmUybmMyQmVpWGg2R1JUNG5NRHh0bzNmaVpQRXpu?=
 =?utf-8?B?L21MdmJaMU41N2FqZ2JsOGcyZVFZTFQzY1cvUlMrZURSNHpOVGtJcFB0RHdt?=
 =?utf-8?B?TVJud3hoTGYzZytsSnJ4ZW5ZTlJyd0wrWEU3SjVsZ2tXRkFxUFEvNTRFZTZR?=
 =?utf-8?B?QWpqb0VnL0xuTkVLeEpzR3ZydndNMHlBUDJyTWdVOXdwVDh4UUlTODRLZ3N3?=
 =?utf-8?Q?sX4V8MtM9r1kke+3lCBFEMfZf?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8dcb67-f5c6-4095-760f-08de38440868
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 23:29:58.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V66Hma15iDmep+3NAfVh8wcKsrIBTNLMK68EWRYoEmpA+ezRfO2+Fcgm88Tb1fOm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6293

2025-12-10 at 23:54, Peter Rosin wrote:
> Before commit 3092bde731ca ("iio: inkern: move to the cleanup.h
> magic") I think this could have been solved with a number of:
> 
> -	mutex_lock(&iio_dev_opaque->info_exist_lock);
> +	mutex_lock_nested(&iio_dev_opaque->info_exist_lock);

Oops, we need something clever for the (missing) subclass
argument to the mutex_lock_nested() calls, which I simply forgot
all about. It should have been:

+	mutex_lock_nested(&iio_dev_opaque->info_exist_lock, *subclass*);

I don't know what sane subclasses there are. One thing could be
the recursion depth, but I don't think we want to keep track of that
just for lockdep? Another is to use one lockdep class for every
info_exist_lock, but that can generate a lot of lockdep classes...

Cheers,
Peter

