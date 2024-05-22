Return-Path: <linux-iio+bounces-5188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D684C8CC434
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 17:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1392832C9
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E6753398;
	Wed, 22 May 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="SJsBo3qA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4AD1171C
	for <linux-iio@vger.kernel.org>; Wed, 22 May 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392188; cv=fail; b=cjED06YiaAgwbqlUfpPERA4ovLGuoCFsXv1VbX21yfbyLoYjLi2beHJVoC95qacoK5LIVwhbdDRkxX9GZV8tHgX2+0rFxMCUNDBCCMgFWbxbOqbeXPmKi0VBA7qlvC8H+1jxhiMzA8MbPq7/LXIw7WBoVy8fxkZ8YWYb4qEDxTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392188; c=relaxed/simple;
	bh=7dVj4ESdnR0wMxFIoAet30kSsxtYuaIFFbVrFMT67pc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZezywmOKvuyvCeMDMJ7uMuRY6WcmDmFP8uRJluViXqqb7AFl+zlX+CNHrBunK0iyXNujYjOZPSGI3xQgdtXXQI+hMBva7/Q09U6oxNUkdBd3F4wQrFTxKkOAiPMfYv/tl/uKnbMtBFRWmChpjtKXWneljS0Q9hrq1wbmstvy1tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=SJsBo3qA; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44LMK30b014929;
	Wed, 22 May 2024 15:35:53 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2169.outbound.protection.outlook.com [104.47.11.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3y6nbck2bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 15:35:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8MfwlsEqBwHI9AXxYBVPu/3oHqL993bfEpNnj7JqOggCS/S6NKjxRtLft3k6cSC17WlZzilT8UEB1+tJ9iwv3Lxvjbx1d2Ksj8AEKrMa+tpLeFJuqSMckaaHXhyXYcLFaxMKPWKmZLqm2XFp4N6A9uutcyyaLmKrytko5O5uF/XdkHlyRTL0pbOk1RrEbDdiOcvvlpnHKw783zsEwKqiy7HtH9ycwv8nrF7SLV9m6lLX8W1Lu3R1OeSGLcbZlRSfcMuSILXyCd5RWI23qufCG/BCciRoQmaxU+1eQ+hzjCw0segfXKuC6NPuQ857J/5C3F2/+2qxTH7lrH8igXmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfdygcwLrnw/MZOe4ZPWqVPTPJoQuWUsQMXwHVTdXX8=;
 b=Zon8ALZ5e5+Eb8R53zeieu0iQXSV3Tt7PRjyC0MxQuyMdXtER7LP5aplpWHPPEpNusmdHKD19okF6pNUfRGp0PkA2fkUqZUtwBeMV5kBSrPQDcK5Y7xjaG1h8mm7EfpToj9AThCP60MvIcSRf6x+KvhUXXoEepGkvuxD4Fw4RUzXXkpHIAY1ZfII2Wjx1CXQ+HVO/CvgF3gNHgfyj//d7pXzfGF6OudfBFjaMTHe6xBzcOQlxlaEQ/v+IC2JXZXAyvG8yMt3RxDxJ7y4HrnxHjMLS1VkSb0VPHAp5wxOMCLox7BzDHhIfd6bIjT08qjWZ3sSuXar+xOx0YfUkKg/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfdygcwLrnw/MZOe4ZPWqVPTPJoQuWUsQMXwHVTdXX8=;
 b=SJsBo3qAe4TNwy67ZWjyK6NDLmtrOrDHWLeloyjdGYvZxNb7CIZQ7p0RShtInbMKoLgDIyJteCqvhkmKDtr53P/etYh30tE7LffaShjtSU1Qphga+quxo9TbytLZ2rd5QooiYovep4vQ47RLiZ4aSQsf0XncWTQd/wLE5CFLmLcCjs3Qkzb5Zx41NVnQzUFn3BILzybMTTOQY20jcOF3eLlbIDFKUWpaxJ/wihiODc48xWSWm2RIHUexj4iB5v4/giQroIJu9mkyYxXScRdCTdkMs/h6w3/fk9RkTS2VNCjjNWiYKyDoBCMWrygfmDHloZ0ynw5hELZanQTeWxxdHA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FRYP281MB3033.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17; Wed, 22 May
 2024 15:35:46 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 15:35:45 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        INV Git Commit
	<INV.git-commit@tdk.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: add support of accel low-power
 mode
Thread-Topic: [PATCH] iio: imu: inv_icm42600: add support of accel low-power
 mode
Thread-Index: AQHaoGmx3kJNOgoKOESrYpcRCRIEpLGO5IcAgAXe//mACcHPgIAE8SQI
Date: Wed, 22 May 2024 15:35:45 +0000
Message-ID: 
 <FR3P281MB17574BF058BCAC2CE087D154CEEB2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240507103056.291643-1-inv.git-commit@tdk.com>
	<20240509141326.00000684@Huawei.com>
	<FR3P281MB175734C16B7C8F430874A866CEE22@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <20240519125253.6a548bc0@jic23-huawei>
In-Reply-To: <20240519125253.6a548bc0@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FRYP281MB3033:EE_
x-ms-office365-filtering-correlation-id: 53561636-6a30-46d2-f834-08dc7a74d91b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|1800799015|376005|3613699003|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?TmCuqoPIyodelWUoBYJuH4q/XvJVlVBWgo9E0aGd0ClQeoW4/Rm+4g+3EV?=
 =?iso-8859-1?Q?zQeALN6In+iva/UsjZ6vJxHY5vvyDgzUh3Ap7u1yLpS74FCgjAemj634AW?=
 =?iso-8859-1?Q?c5MuKc3wRB1Rf4Jeg/4PpnQfVSP793mEm3XgN4gQvmdRPxt3qafFrwPPQA?=
 =?iso-8859-1?Q?l5+dg3VF+EP3mLwM0AeJaWKx6dBoP3HELxy9GL5Neka+u7jm60syFwY5ZJ?=
 =?iso-8859-1?Q?YgPNtyyG+IOLb2Ypwan6vIVnCW3fwFEZ5PrlehXhaKrev3WnaE6QKxszXl?=
 =?iso-8859-1?Q?yKCVQT3GEzr9TY3o3Hq+jA+Wq+e+vpdts5/DmW5lapHGrDXRCeFL43ZP8R?=
 =?iso-8859-1?Q?rrNFXgaKwB3IV8VguWuvEv2fFfT3tOg4M1eIGZSSJP6YfZ2a/ie3dGoW25?=
 =?iso-8859-1?Q?yo9CwqmZ+JDJnTnow24CloiOE/rLcbP4dYFXEpGmDMrzvQPe3KrQD1kIz3?=
 =?iso-8859-1?Q?Kj4x1mK/vLGxYo8qpVLnJ2gwmvuQUYUJ8y4nGHVgt88zFcjfnqhVXDaANG?=
 =?iso-8859-1?Q?ZNaSLpdkltCvKmEYmReE/HPlRPOXfcNr8B7YvLlZApYuuDGFEGSG7EuUdS?=
 =?iso-8859-1?Q?2ALnnR1+72I/YQmNK1/N2b85p9pW3a2SCwIq6zvrSj7gmxqwkNf28uz40R?=
 =?iso-8859-1?Q?R0jKsHK4eY8yJt2o9dGB/BPpy4qymyJauqe0BEjlWGeFPRtqVzS8Pucoz3?=
 =?iso-8859-1?Q?4U93128kBdn3DJ46mDBqB8D+s60Eie7mKu7++QqjV0qY9Gx8Hu6Tbcyyle?=
 =?iso-8859-1?Q?autYaip0vrgvn/+E00UpyFldmTizK1KEClrv6libuCyWs+LTzigIFSaS6t?=
 =?iso-8859-1?Q?mHyY/X+Pq+MUeeIWWMXivVRuM9InjvVoghR8dEDxeGZHeum+/VoVDN/3aP?=
 =?iso-8859-1?Q?gZvAGK4/gSBd6KsDbsQ+sDakVbVZ5kbXd8d57WP7TSkpqIRYx5U2nHujxh?=
 =?iso-8859-1?Q?U+fhGpdQv34bs7x3zIpLEeO7hSS7explJA1c4+ZlHksWbQzstRM8shtmmg?=
 =?iso-8859-1?Q?Z7AcepfBZ9wsiYw5lwf5i+fITJFPZ2oD9zwxvuGfGhRErlKtg+ocftZMrs?=
 =?iso-8859-1?Q?CtQz2RPOhtMxTZ7FNxE3ayPRCQCbX1nDRU10PTUcVHMDhhd1JCOopgezgg?=
 =?iso-8859-1?Q?9eCUobh8p4QPbU2uVYnkIvqm7vVP7FCDCvl6/ffrmf6AuEcEBLXZKrt/pY?=
 =?iso-8859-1?Q?ExNFHXqVtjf3tKsQfYg5ydF4xnwixjw66WW4V5TuOvgbe5d91TRF0sXu+T?=
 =?iso-8859-1?Q?qGQ9PHMzCVVIS3YRYWLXdX6wpDAEXl0NHQs+dSX2tzp9L06vzsD8/ViSqs?=
 =?iso-8859-1?Q?91gTFAf9OAF/yD87qDRfomsh/VciA/YWCVWMO1plb0QOAskzb9o+2Bwht4?=
 =?iso-8859-1?Q?6SC5z0bRSAmLlBpbq/8ad+brn9NrZ7VeOEkt+EE0c4uD8J0loWIUE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(3613699003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ek2+YjowvzuRN0eN5HIjpVt4lGbzhAmOYuUHXy3Y7L3A2WOR8iWdcJDXix?=
 =?iso-8859-1?Q?1HKAAhvKnuM2ECb83f0Uocg0Zq1FodpAdVRbuSctFh6Qdb50hFxEixpkG0?=
 =?iso-8859-1?Q?CrmAaN/OWl/YyMD4akwU9rctWpiBcftZoJO8jscoAK+LLNwb9YpyvQcdiP?=
 =?iso-8859-1?Q?4GKCyp09OToQpPoMNuaTd1fZUcvd+E46lwqZx/NUzCRrisx708H0m4RQ/X?=
 =?iso-8859-1?Q?7HYWDKsm24GqMhjuHCNyDnyecjnzUESUrsnHdYhnm9fv3iB5/j/lou1s8z?=
 =?iso-8859-1?Q?nVTxU2D+Ex0aRuXuWkUfSRktP/Js/xYQ8fRl8o/j8VWgiy6Zd+VsHGe7M0?=
 =?iso-8859-1?Q?7vcxAlgaKy0r1WrCtL5DB5yNWbbHNIy/jgDoJhQzQ3l/DnD6n+IwBhjb8R?=
 =?iso-8859-1?Q?BRUE4YqR9Rgn4lTAglgKTCq1SEcmAVGDp9iERSWylmOKX6tPDdNxSjAiKK?=
 =?iso-8859-1?Q?DxUq0wKCfd7tivAA9nBqxqLi2FimBDPp2re0c2ZxSPgY+vX9CiStgO9u0O?=
 =?iso-8859-1?Q?cuA4rcI02hNmkXyFZFnD3fKmeBkcgwPqhCm22S2/nfhIAjC0CMpJTfojGm?=
 =?iso-8859-1?Q?12YdnxFFRv6jMn9uNHySCnm3MvexdDoEPmMTsasuHt15FfK8hHJ4jXg/i6?=
 =?iso-8859-1?Q?wy254oy20V+2n6VPuk9BmPxfvMrfi9xiJzRpWSDLH9u7BiK1RpynKiCLW6?=
 =?iso-8859-1?Q?VKWTrBIlIJPnM8+CJ6xbeyJ/po5EVNxvf0bFVBaPcTkXvZTtt886uRgv5b?=
 =?iso-8859-1?Q?I8ntY6aT6hCmh5CfacIPTbgGCtzQ9MF2rlmjlr04X2v6jhQ4EzLP5t/SEk?=
 =?iso-8859-1?Q?vC/tXyJWjx5qYdheecFsvC257PFQWotMLi7jQc2XA4nY6maoAUdK5pBm5q?=
 =?iso-8859-1?Q?imUYlaLA8ocq1DCOIcID53tAengUBGsX+WcNu8xo4/Uabb9nEdQ20bMqAX?=
 =?iso-8859-1?Q?G37hkEWPEy1hALc536bvbmeWUejyrmB0OJuWat7l8byZW0FjpdvvuQEb5S?=
 =?iso-8859-1?Q?KXVTC358aAxyLAexU9zcfc5qAGmyzs6v12O6Y20euteTosSjlKSpRupNFL?=
 =?iso-8859-1?Q?SFRSJ74bzZvlizYNz6f9/MtHMIdYJZLpy4yXxDKy5SrNOUvmxuVA+ntr5h?=
 =?iso-8859-1?Q?py6bDkZKfuMgT+UsiL6DvXB2Tjyi8/2DyVra5J1k7KgBhvAGKg1G4hxIu4?=
 =?iso-8859-1?Q?t3bA59UVS5xtQ9NA5TjECuzQBG1EcGcr6pff36Jw7ZUwEz1mecLIGg0Lh1?=
 =?iso-8859-1?Q?QkjIMUQ8Vqg0jHKfDngURWN3vCCUo/8Yof6/EMUAcOWdF7xolcyKaSdbbp?=
 =?iso-8859-1?Q?vlMwJiCW2EFH1lKzhyEfevlm4yR8Roc/YZxYEFWQNd05O/mw/HBhmycZSp?=
 =?iso-8859-1?Q?wQ5Ka6Gqx7chjonuuqklXg+Z+xXKAVwoKa3hFzzU1E5/1cNM0Oxk+FKdBs?=
 =?iso-8859-1?Q?4WBtnlrfvvjLyf9ZdfnyCoquM2my8ZNxQsBaBFCNltgKg2OTbEm14osZsJ?=
 =?iso-8859-1?Q?cxcSh0gE91cicj81gw515f9enZ5p+WaPrCNKbhT+tcfq4MpykKVEsAN/+7?=
 =?iso-8859-1?Q?MlbBaekKPxzue6anj/viK7QxyRaDH890PoAKB3gaEPyo1je1j77m6RPSkI?=
 =?iso-8859-1?Q?+DtI1xCUfF2cpMe/JNYd6RskilXgYmWn4GEfroMs7NwFawn+/5X+wb2V9w?=
 =?iso-8859-1?Q?32ruaL3Lz+EohQZoP2gdUmJYhvQhQkuanCj+GlDCw7ESKR/MD6DdUcqP8l?=
 =?iso-8859-1?Q?sMnQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 53561636-6a30-46d2-f834-08dc7a74d91b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 15:35:45.6641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipjWo/EaF+mv/XM6j7hntO2LLfYq69OSTEXbAa9cl6MdVRR/Zjv1E9mVQHBiACFkQYr9cxStg8sAV4xL7S5665GyTq+ZkFSvQlhqx+ikzmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3033
X-Proofpoint-GUID: Ydj8wJHX0nX_5B49F_dQscFcnRQNWONk
X-Proofpoint-ORIG-GUID: Ydj8wJHX0nX_5B49F_dQscFcnRQNWONk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_08,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011
 mlxscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405220105

Hello Jonathan,=0A=
=0A=
the hardware bias changes (inside calibbias exactly) is due to the noise di=
fferences of the 2 modes, introducing a little change in offset (these come=
s from the MEMS mechanical parts). This change cannot be anticipated sadly.=
=0A=
=0A=
Most of the time, the low power mode is used for accelerometer, since most =
used accelerometer features are motion monitoring in the background (pedome=
ter, activity, ...). But high frequencies can be needed for very fast event=
 like tap our double taps on the device.=0A=
=0A=
We could default to low-power mode and switch to low-noise mode automatical=
ly only for the high frequencies where it is mandatory. And we could add a =
sysfs entry like low_noise_mode to enforce low-noise mode for lower frequen=
cies supporting it.=0A=
=0A=
This way traditional userspace can ignore the power_mode setup and use all =
frequencies. And only specialized userpsace components can set this low_noi=
se_mode to have better noise values for specific use cases. For the hardwar=
e bias issue, the high frequency use cases are usually not impacted by the =
absolute offset, so it should not be a big issue.=0A=
=0A=
Is that OK for you?=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Sunday, May 19, 2024 13:52=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Cc:=A0Jonathan Cameron <Jonathan.Cameron@Huawei.com>; INV Git Commit <INV.g=
it-commit@tdk.com>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kerne=
l.org <linux-iio@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH] iio: imu: inv_icm42600: add support of accel low-pow=
er mode=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Mon, 13 May 2024 09:18:34 +0000=0A=
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:=0A=
=0A=
> Hello Jonathan,=0A=
> =0A=
> sorry for the patch malformation, I will send a V2 fixed.=0A=
> =0A=
> Our chips have usually 2 working modes called "low-noise" and "low-power"=
.=0A=
> =0A=
> "Low-noise" is the standard mode where the chip (ADC/MEMS) runs continuou=
sly with high precision oscillator. Measures are the best with the less jit=
ter (low noise), you can use the highest possible frequencies (> 500Hz), bu=
t power consumption is high, and you cannot use the lowest frequencies (< 1=
2.5Hz).=0A=
> =0A=
> "Low-power" is duty cycling the chip, turning ADC and MEMS on only when m=
easuring and then turns it off. Power consumption is then much lower (low p=
ower), you can use the lowest frequencies (< 12.5Hz), but measures have mor=
e jitter, and you cannot use the highest frequencies.=0A=
> =0A=
> Depending on the use case, you may prefer to have the "low-noise" mode wi=
th better measures and high frequencies, or the "low-power" mode with less =
power consumption and low frequencies. The main point is the frequencies av=
ailability depending on the power mode.=0A=
> =0A=
> We could have the driver switching automatically from low-noise to low-po=
wer to support all possible frequencies, but we need to arbitrary choose th=
e mode for the common frequencies, and the configured hardware bias in bias=
 registers are not the same depending on the power mode. We prefer handling=
 all this from userspace, switching the mode when needed depending on the u=
se case and dealing with the 2 sets of hardware bias depending on the modes=
.=0A=
> =0A=
> I hope I am clear enough with my description.=0A=
> =0A=
=0A=
Whilst I understand the motivation, the problem with this is that most user=
space=0A=
software will have no idea what these controls do. It is very challenging =
=0A=
to provide enough discoverability to userspace because these modes tend to =
have=0A=
weird and wonderful side effects (e.g. the hardware bias here).=0A=
=0A=
So I'd very strongly suggest at least a 'default' option to figure it out f=
rom the=0A=
requested frequencies probably defaulting to low noise on the common freque=
ncies=0A=
- "when in doubt give the best possible data". =0A=
=0A=
With that in place, I'd be more likely to be persuaded of the need for a=0A=
'tweak' bit of custom ABI that overrides this automatic parameter setting.=
=0A=
Thus things would work as well as possible for normal software, and advance=
d=0A=
software, by which I mean your userspace stack, would have access to a way=
=0A=
to bias the low power / low noise decision in the common frequencies.=0A=
=0A=
The sticky bit here is that hardware bias. I'm assuming that is what we=0A=
are controlling via calibbias?  If so is there any sane way to relate the t=
wo=0A=
sets of bias values?=0A=
Normally (I think) that stuff is about fixing variability in the analog=0A=
signal part of the device, so I'd expect any change in value to be predicta=
ble=0A=
unless there is something odd going on with digital filtering perhaps?=0A=
=0A=
Finally I do wonder how often people use those mid frequencies where there =
is=0A=
a direct choice.  In broad terms the reason for low power is to do detectio=
n=0A=
of background stuff - screen rotation etc in which case they'd also pick lo=
w=0A=
frequency to save even more power. The low noise modes are for when the pre=
cise=0A=
data matters a lot more and those tend to also need at least moderately hig=
h=0A=
sampling rates because people are typically running some sensor fusion on t=
op=0A=
and accurate data but at low frequency is usually no good for that unless y=
ou know=0A=
something is mechanically filtering the motion (i.e it's fine on measuring =
shaft=0A=
rotation on something with lots of inertial, not so much human motion).=0A=
=0A=
Jonathan=0A=
=0A=
> Thanks,=0A=
> JB=0A=
> =0A=
> =0A=
> =0A=
> ________________________________________=0A=
> From:=A0Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
> Sent:=A0Thursday, May 9, 2024 15:13=0A=
> To:=A0INV Git Commit <INV.git-commit@tdk.com>=0A=
> Cc:=A0jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.=
de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Jean-Baptiste M=
aneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
> Subject:=A0Re: [PATCH] iio: imu: inv_icm42600: add support of accel low-p=
ower mode=0A=
> =A0=0A=
> This Message Is From an External Sender=0A=
> This message came from outside your organization.=0A=
> =A0=0A=
> On Tue,  7 May 2024 10:30:56 +0000=0A=
> inv.git-commit@tdk.com wrote:=0A=
> =0A=
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> > =0A=
> > Add channel attributes "power_mode" and "power_mode_available" for=0A=
> > setting accel power mode (low-noise or low-power).=0A=
> > =0A=
> > Differents ODRs and filter are possible depending on the power mode.=0A=
> > Thus make ODRs and filter dynamic and check values when applying.  =0A=
> Hi Jean-Baptiste=0A=
> =0A=
> No Sign-off?=0A=
> =0A=
> We have never provided this sort of control because it's near=0A=
> impossible for user space to know what to do with it.=0A=
> =0A=
> Various attempts happened in the past to provide enough info=0A=
> to userspace, but didn't succeed because what low power means=0A=
> is incredibly chip dependent.  As a general rule everyone wants=0A=
> low power, but at 0 perf cost :)=0A=
> =0A=
> What are the results of low power mode? Normally it maps as=0A=
> something we can enable when some other set of states is set or=0A=
> automatically control based on how often the device is being accessed etc=
.=0A=
> =0A=
> For example, what do we loose by choosing this mode for everything=0A=
> below 200Hz?=0A=
> =0A=
> I see there is some reference to 'low noise' - what does that actually=0A=
> mean for this device? Is it oversampling or running lower resolution on=
=0A=
> the ADCs?  If so those are the things to look at as ways to control=0A=
> this.  Choose lowest power to meet a given set of requirements.=0A=
> =0A=
> Jonathan=0A=
=0A=

