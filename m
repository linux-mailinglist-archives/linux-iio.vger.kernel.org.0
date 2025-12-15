Return-Path: <linux-iio+bounces-27082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C353CBDF9B
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 14:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A542300BD84
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 13:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E302D3A93;
	Mon, 15 Dec 2025 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="Mp9uXIZR"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AA2DCC13
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804656; cv=fail; b=L68urKynSQBZq+JCma1Hgq9wQx/peTSEN3mAqID26RVT6L8imiGTF64DYMygMTGJXiWAAL499JExuHzByuEPqdHbyAty6hsHSfNYkpHeMJP85/kDpqGk9UMO5DwCq+Se1nj1pJ4sYDi5vgtrQ9NxakvZu+ZR4beagI6YaHVwZzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804656; c=relaxed/simple;
	bh=+3i9zplZxQby8TysRmoNSUvzUpJMrov5EPQEfzcepDc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cyCNmF6Sxpxshp53GSDa0yIV3xa/KFNjpGCvcg+nFD9rsJMBc5qImRsmXFNG/nb0ajZH93O9BeznTxoXNH5cgnPhqrzQyWz4la6NkbEHxNJcfrpuTCFBSorpbuNsfbT5iHzFTfaK+7VYZbDmRYFEReSOtZSZ37YJm3IoyxaB8Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=Mp9uXIZR; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfKl9gFfRgnfCkXzvSVlNj/Yl+GpyCvJQKi/BlcmrYz0mVjbEuwQAnVFZ+b6B6eiEk/+WvWnJctmpDGqMCkMlFC4267IAhJ8CKYeaE6IzcIqWaYqj44G2dtS5abOFRNkVyWH28BexfYQaSvFvsejpSUXnHwAAv7gcKC+c9Spu+a2Fz4L4dp8SgJVq/8sUxnUIJfPG8E5q+lRZI0lNfRiSfLs9qSWXKRRcSh5iN4zRVVbNTEqiGtdcnTJ08W8/EJcUtWhQUz+3ips4L649kBB9owEuKT7OsYtucVkltb5ereTHSM/YqWPCeTIaJZbBNsHrqf1DdPQUaxKRgvbvs/RJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAjpb8PKahKSlTQtiQQ5c8bO27D2Fu+j9TVTIHkmB/k=;
 b=TdYfj0vAO23iMbiv7vz621Up05bxU7bj9rOW0V/T1dvXW/NexAN1Da0i/NCmwYRNvuPADGIjaIk51gTfg+GYWiL/vEi3085Wac02I5PPmgdWKn5tw7GjTbTznm9Aj7q8UcIdarZEGrGVMcsfYfYVRbl+DCC/tnbKC6gU+00PCz4PZP2YwJPx4B4RORShBRhT32kVi27sDLs5Q53P3MZBGN83Jn43HzT2JVBGvBwzNBs9b3db1r8wlOcfSwxkd2TKP5mVuDgTYk/29l/9onWf74zzVx5i45ncr5puzzxqjmyVt++m+UIyd3s8Ve6zQaT7YVJIkWs23Kr81yYjUD8pZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAjpb8PKahKSlTQtiQQ5c8bO27D2Fu+j9TVTIHkmB/k=;
 b=Mp9uXIZRhWZSnaWFok47XvyYkgQz3GyIwPMsZB88UkAFxix70RAXUZE4M39CHlgN/CQ4pyyxvp/leHzktk5yjlNQq0iPPix1rRy+XUbcJQ0gdEBZxGSVY+mY888TNaEB4bXmYgHpsaStJqgRB7jnKKrjDlPYKSPQ/g9oG1K6+Bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by FRWPR10MB9227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:17b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 13:17:26 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 13:17:25 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Guenter Roeck <linux@roeck-us.net>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] iio: core: add separate lockdep class for info_exist_lock
Date: Mon, 15 Dec 2025 14:17:23 +0100
Message-ID: <20251215131723.4130826-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0119.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::15) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|FRWPR10MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 1628e81b-ced1-43e9-ab3f-08de3bdc4a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?09QypuDpluu23EoMDJ2KxAeo7fl/x9zxY0GytoODC+XiDLHA0p5OayyrIpCW?=
 =?us-ascii?Q?sdY2MztKQ/hNESY1yfa6NQjpJD9FAh+mpKaVT6NfaDYUv9FaMivbEHYBXKmn?=
 =?us-ascii?Q?tJaNKCNXZpUIKsSB+D/KXRB95Rb+cB5J3ZJVdGhQYKWh9J9THy6ACUnBjMMU?=
 =?us-ascii?Q?WxlTzjel5//PE+utJ5+8vKtCQ9pGL7ytk2LnPem4otECu9IFiLezTkTj5C+0?=
 =?us-ascii?Q?4unX02PmefPmBVuotCBLtX68mX37mpvGn0A/HoX16I/47wV1HrQotLoV0kYk?=
 =?us-ascii?Q?HCwFb30oxLf5hhtQcowpSgdfKBh+dutrlay3mD2x5wMkpukBqWGJA7c1TXIo?=
 =?us-ascii?Q?5ha+PfXYVHWAzM9DqkCCxMIgVYf4ygzbaoqj9/m2vHIdeveuCpotzKmK+f/a?=
 =?us-ascii?Q?a2kPDMJQr79u5FW+Ph7H0dv36gT3LnuPrHvw7QnRvpHaNvrTbVF38gETIext?=
 =?us-ascii?Q?ZbrBTBpJz8sezbqb8Kt0SRh6W7qg4PfEx80AKlvjfQ0ja9j+szGTJZcGWvgv?=
 =?us-ascii?Q?DVSnlwA1N/stW5fU4nzx9R56dB5ZoNRo4zfS8sGE7inulpyLF6btxf6kYG0U?=
 =?us-ascii?Q?aBGOlYvpa1u/NQZjDucZPZFq4SxDITocRa2Lt/FoirQG/2J0lKToqQ0L+Hdj?=
 =?us-ascii?Q?1anTVxt4bX+Q6CXqcx0M2n70OL8iLOMcmJXZx5LV33LHSykVIxDxdZbByDwf?=
 =?us-ascii?Q?0pjI6ZiOq8RQ5bDTSce0SIR5KKWjj1J6K/Ys4vKDDSiTtAXBkx0vyFpGMqLH?=
 =?us-ascii?Q?vjrJpn21WGy80ysdfmxcQWOOtftLmT4U0dC6gPJw1ByKB5JlVE9DgHW8AMGL?=
 =?us-ascii?Q?jMP0faftnp6523Y3mBk8z8D0cw5/bu2EY0s3ADYWY0eGyjmGv7Pi10hGiRFK?=
 =?us-ascii?Q?mrzE68cf+/AasoDTNJW2dhRDZcOMxdw+gONGNntuAcHvbdU871b2msOevTpY?=
 =?us-ascii?Q?L6v1MpOmi/+ouK9aA8EWJJd1Da3jg2cBJvZZj+CthmhANlXSn9verggHUQVP?=
 =?us-ascii?Q?eyZ4a4GtxlNof4Icunt+OxLoT/iVRsd5/+OTfO0DTVRuXEImdb0ETOuK0+k0?=
 =?us-ascii?Q?IMWnqDLkNNhwhWdka7sg4bX51G6DxIMM4JmPgp68QsmqdaxBCRqxluEhAHRL?=
 =?us-ascii?Q?lLYB1RyG0C89VabNX9EDGAlMV0E3RiBqY8+fpUc+ty5ARGbOBLxCtdmJRqjt?=
 =?us-ascii?Q?ViuDoTEjb5LsoVRfnOUJJc0DJej1A/CqXY15edAvE41EL0DIx6MSGgqKT7OQ?=
 =?us-ascii?Q?NJQ6sfSEtLkIelarKozISx2TjdDNiYtdkdQp9ilwSnLn3FTxwIBI8fkqDycy?=
 =?us-ascii?Q?Nz64fTzwEl0PuID9fmIGletzkIzbqjV2M7ewao6bc+tq/tux/6zoQfLWu5FJ?=
 =?us-ascii?Q?rSvuCwlScVLWGjO1JJWBmkVlh8rlQD7ns5kqbDmEpUt+GkZiHmZZb8sX8yPQ?=
 =?us-ascii?Q?v3emPnz4CG7RDSvxH+Es10VZ9hdqrNswcBnvyKgcOomq2Iq4M56O29JEk9lM?=
 =?us-ascii?Q?yJtkCb16xiLlpBvtumcRZDIlH47f8hOwlsUV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ep02/SVnWXtlA7VEYBvg+7pSBczzOfqy9aaN0fg9O/BEypIKH9hV80GTt4+s?=
 =?us-ascii?Q?0lRh3fT2VyKWk3dwyveLlWQfV8h3DrB4uaNs5QaKGDomlTE8aqaZQW1MiKjp?=
 =?us-ascii?Q?WTtUyhE0cD/XnWejYkHKs9+bYj6ghNWPLyq0lchJCPurhqSPUKU89JPOvpI3?=
 =?us-ascii?Q?vOUyn9ewTESBygyaj4cWsQiR6qOSQ5lHQa4Xa/8vx+56n1n/efq3OhK2lEko?=
 =?us-ascii?Q?PDkETU5tUZFpjhsF0LtwQrX1968VUp2+Cq0ugZA+pfRpeS9GOihn62v+ILmZ?=
 =?us-ascii?Q?NkOoWcIN/5mK/4I4+sHv5QuajQ57f5NWYc686Ewo1/uG+v5pjADoDLmu/Jx3?=
 =?us-ascii?Q?iXC6oE6hopIQee3MDVB4/quxTduNpPdjaZ/PDD/+C9StGv9dNx5AKJP0GQbL?=
 =?us-ascii?Q?5bMupNMgdF7wOJMsZ93fKqq2FwGAPc/t+E03N1SBxMtdrwZW+IGMzsGXcXW3?=
 =?us-ascii?Q?1rcrNnsbYAbDv00yueEU1o52nIKz/rBf9ZHFzZtw1FghuNptaZmeMCDepOnC?=
 =?us-ascii?Q?vW2iqyWuJO/A5K9ftKTGHL68J/xJz61DQQV30aqbi2h5Cam2UCQrDxSmNolp?=
 =?us-ascii?Q?uL5eMqIY24tMSvIEC5AS5iiwiIRQBSKtd0vFw+6tMI/rsu4cCdGZ7YD3sJrn?=
 =?us-ascii?Q?yQgnsVy9x/4zD5fx3aKpnuepXQdI7LEe0FdUpXMr8xhBok4shXq+f0ArLP0V?=
 =?us-ascii?Q?CvsYyLSAfcQ2VLIJ8wdb/MpSOqvv6tdCz6UkpQsaPCZwFp+Ym81qFap5Bpsw?=
 =?us-ascii?Q?krODnR9j9Dxy9AdAIZGmnwiaHJN+yUU17IKNpLe+koKY9pEUyGbSIoQZvW85?=
 =?us-ascii?Q?/vGwNLrc4uq2cgweNCxmeaX5haq/tx2jwUkxnDMz7SDZNOvXhORz4I3enoDp?=
 =?us-ascii?Q?pKY6yRzDpd+AWc3wJkHUz2KSKoeuPjtt/U1TQxm3D4Vtucik5WlSM4/tSysq?=
 =?us-ascii?Q?x7EEO356QuzQrl+POa6zgg6WI9bTMboxyqI8XRRj/HCJ/fwQt4Pqen6HVC0B?=
 =?us-ascii?Q?UDievD/XV2KakZPtvvZjkJqS4v5tOVfQPlOenoRrLGbOsLBJ4HDSwj8r7hbE?=
 =?us-ascii?Q?lVJZinfDsfHcFenqraSNAYpPqr7b7a3XXWwCiUqNmF7QNkvWNkoUm1bAKPAL?=
 =?us-ascii?Q?XwUErIanhh069/adLI+yzWlzEgHuxTWmLOB2mvJzyQOVQst0b44vjtQkyD4X?=
 =?us-ascii?Q?4O6wC6oSyREnAUWJB+WFT1d8NYaPnQ7bUBH2xPLqTF5iQ+MGujWVEGrP+1+s?=
 =?us-ascii?Q?i4WUEb2y8mcgUAqsW8MN1iGJ02gEr7Mxm2LSMcqN2gqytNTFxsWM3gk28FeC?=
 =?us-ascii?Q?THi5cnhf/AfMmVPdXfhtEXLelLw3ir0tmd8uLf8toave7ciRDW95M/AEhHs/?=
 =?us-ascii?Q?mCyPFjzgOnDA645fCNBmvonRSWvgIYX6qgz43bZ7iOVTChwrQSnQVwSTKOS4?=
 =?us-ascii?Q?oBz5bjnduxI8Cn991vaFiTdDPydhK7yGwNS/eaAlkKYHN5m67ndajqUMTT/j?=
 =?us-ascii?Q?YK9/kd8tVslXuIkl9zkTOvOF8euG8xcIcCCrzt2xLozklDjYapU4sjSDbg7r?=
 =?us-ascii?Q?BDkGRhpca5NVYh45vP8/tiiTI2CGBnx564Ul8RJt5bOOSOju4nyU3EABzFNP?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1628e81b-ced1-43e9-ab3f-08de3bdc4a33
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 13:17:25.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eX7jagUOS65mOgTDHFCO5+SxJs7zT0Mr6izgRHeGgGlctVe6AT5JKaQ7OTMItnI5gH+W4tJsPdzWzEDaT/dz3Oi6iMySD8HAR3aWM57RhFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9227

When one iio device is a consumer of another, it is possible that
the ->info_exist_lock of both ends up being taken when reading the
value of the consumer device.

Since they currently belong to the same lockdep class (being
initialized in a single location with mutex_init()), that results in a
lockdep warning

         CPU0
         ----
    lock(&iio_dev_opaque->info_exist_lock);
    lock(&iio_dev_opaque->info_exist_lock);

   *** DEADLOCK ***

   May be due to missing lock nesting notation

  4 locks held by sensors/414:
   #0: c31fd6dc (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x44/0x4e4
   #1: c4f5a1c4 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x1c/0xac
   #2: c2827548 (kn->active#34){.+.+}-{0:0}, at: kernfs_seq_start+0x30/0xac
   #3: c1dd2b68 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_read_channel_processed_scale+0x24/0xd8

  stack backtrace:
  CPU: 0 UID: 0 PID: 414 Comm: sensors Not tainted 6.17.11 #5 NONE
  Hardware name: Generic AM33XX (Flattened Device Tree)
  Call trace:
   unwind_backtrace from show_stack+0x10/0x14
   show_stack from dump_stack_lvl+0x44/0x60
   dump_stack_lvl from print_deadlock_bug+0x2b8/0x334
   print_deadlock_bug from __lock_acquire+0x13a4/0x2ab0
   __lock_acquire from lock_acquire+0xd0/0x2c0
   lock_acquire from __mutex_lock+0xa0/0xe8c
   __mutex_lock from mutex_lock_nested+0x1c/0x24
   mutex_lock_nested from iio_read_channel_raw+0x20/0x6c
   iio_read_channel_raw from rescale_read_raw+0x128/0x1c4
   rescale_read_raw from iio_channel_read+0xe4/0xf4
   iio_channel_read from iio_read_channel_processed_scale+0x6c/0xd8
   iio_read_channel_processed_scale from iio_hwmon_read_val+0x68/0xbc
   iio_hwmon_read_val from dev_attr_show+0x18/0x48
   dev_attr_show from sysfs_kf_seq_show+0x80/0x110
   sysfs_kf_seq_show from seq_read_iter+0xdc/0x4e4
   seq_read_iter from vfs_read+0x238/0x2e4
   vfs_read from ksys_read+0x6c/0xec
   ksys_read from ret_fast_syscall+0x0/0x1c

Just as the mlock_key already has its own lockdep class, add a
lock_class_key for the info_exist mutex.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/iio/industrialio-core.c | 4 +++-
 include/linux/iio/iio-opaque.h  | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f69deefcfb6f..117ffad4f376 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1657,6 +1657,7 @@ static void iio_dev_release(struct device *device)
 	mutex_destroy(&iio_dev_opaque->info_exist_lock);
 	mutex_destroy(&iio_dev_opaque->mlock);
 
+	lockdep_unregister_key(&iio_dev_opaque->info_exist_key);
 	lockdep_unregister_key(&iio_dev_opaque->mlock_key);
 
 	ida_free(&iio_ida, iio_dev_opaque->id);
@@ -1717,9 +1718,10 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
 
 	lockdep_register_key(&iio_dev_opaque->mlock_key);
+	lockdep_register_key(&iio_dev_opaque->info_exist_key);
 
 	mutex_init_with_key(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
-	mutex_init(&iio_dev_opaque->info_exist_lock);
+	mutex_init_with_key(&iio_dev_opaque->info_exist_lock, &iio_dev_opaque->info_exist_key);
 
 	indio_dev->dev.parent = parent;
 	indio_dev->dev.type = &iio_device_type;
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 4247497f3f8b..b87841a355f8 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -14,6 +14,7 @@
  * @mlock:			lock used to prevent simultaneous device state changes
  * @mlock_key:			lockdep class for iio_dev lock
  * @info_exist_lock:		lock to prevent use during removal
+ * @info_exist_key:		lockdep class for info_exist lock
  * @trig_readonly:		mark the current trigger immutable
  * @event_interface:		event chrdevs associated with interrupt lines
  * @attached_buffers:		array of buffers statically attached by the driver
@@ -47,6 +48,7 @@ struct iio_dev_opaque {
 	struct mutex			mlock;
 	struct lock_class_key		mlock_key;
 	struct mutex			info_exist_lock;
+	struct lock_class_key		info_exist_key;
 	bool				trig_readonly;
 	struct iio_event_interface	*event_interface;
 	struct iio_buffer		**attached_buffers;
-- 
2.52.0


