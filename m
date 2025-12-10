Return-Path: <linux-iio+bounces-26994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB6ECB3277
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 15:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07EEF316DE08
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832FB239072;
	Wed, 10 Dec 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="C60ksIg1"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013026.outbound.protection.outlook.com [52.101.83.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F315ECCC;
	Wed, 10 Dec 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377095; cv=fail; b=pIo9Wl4MUQui1TMs0DVrt4B7bPa3XXIBDByoDtk+V1Libv0Qvx1n0QvXHZA6q6GdURJ3R7jE6zyRmWTMIW6/iqns11ys2e6zsRNo8Uc0+grHVgxoTe7ynQNKZyYjYjEHWuIP9HuqNNXMz6Uv89dm/Lm0ZbvTC8cA/dSCNFnMhGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377095; c=relaxed/simple;
	bh=BUdM2YyUQq0tLXTE8TJPz41qxyKUVYAVQs0MLB0bOgg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bVx+5kqJmtznl/CMWWSDN5y+1Ya3ALljEzSMK0cYbRaFtHfgu7st8smVTfQb9aNWUmVtvKfW+B42rzUrztzfViu+2mXPPpFYEuFrLEJwQtu8UYcpSr5IQja/m0qx6BvhgKk9BrXY/zK71p7PUcdwq19ociigyxdzEb5H/3jexSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=C60ksIg1; arc=fail smtp.client-ip=52.101.83.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XThJSKyYlMJ3G94eKbQjNMetk1Dod6qO/QNk+N5pEs71hhckGhcr17lCf2NkTyATzT6NSKiZ4+1vJitc4pmiXsNw+UMogdytU4PpGcU3WG7/dXNtEJsTenI+A9bJYlVawfBOEA+bXbuJgIE70mZERHxQCU5rRCetX2YXNVGJyAxGgA3gr0iw2deN5RYk4Bbjf5TrO3zublnnOzEfRFKpQSyCCvvuQDf7FcVN0fPTW7Tu28EnCjtdJM+qhd5t6uFTJg43yOWbNWLVKwDfKbWP0Kpskh2RtyU65x6GNeN4HzG4EozFPmywcbrHFHkLm+KARNAw6ipaCI4qWVRnkTS4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23Hibm/p4E83mF0+9T+JyI3ueyGIgrQJCV9xiO5TmjE=;
 b=qSAaKIBnaYccEbfOSvoSfHqsG9nSD9w++c/f0hAQvDYjD9kulYSMDvm8FSwkwq/oaKQRtyH6Adv3Js8Ldh2dDuQMaIbPlKTA8kQ6PWPr+pNqDp97nHv2z2bScQvpeLah1k9YqFHmOLGrk962l+uto7S2oHDjkjKTaF9V6dtABDxko/csHPOOt8UX18GNdaUPYK2izmBCKGJ8sNeQh/8ToR2xBmzasILjeB3X0nMJH3IBa9DaQlpIsJUg+h9i8ukMc5N7Kr8/CMl07Ki1wLa+1E8ePSb+U5uI0B/qqzdMhxKO2NqvFotgo8EhzZCiLmWt/Wh9tSqKBys7KLTISLxQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23Hibm/p4E83mF0+9T+JyI3ueyGIgrQJCV9xiO5TmjE=;
 b=C60ksIg13aUrIZYrtKXyN7z26+f5nzO6ICJaLD5glqL0WMoJbGD1RIXoKeQm5ETKTDzx9S3b8qxkBiDy/oglW8EhhOeJaAlMW2d5YHViekJIBterjzob5M9ejnsHzI74a5pgbdtvjJBVsrI3KJs4dwngVLYwZAJN1q0kOTtWdBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by BESPR10MB9314.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 14:31:26 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 14:31:26 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: lockdep splat involving iio-hwmon and iio-rescale drivers
Date: Wed, 10 Dec 2025 15:31:25 +0100
Message-ID: <87qzt2tnlu.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|BESPR10MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef1bd71-aa5a-43ff-a87d-08de37f8cd1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wajyFSgmm8pl/oOSuejkd+Msv4a32U66g1hhgAaHUUGdGD+V4QR0QigB1GYj?=
 =?us-ascii?Q?DYml2f0MqSWb8eR3lJ3ys+c/UvXTZAjSzwee7R7Nh80wXxwlShbNtk8zs3ln?=
 =?us-ascii?Q?k2qWTdO1r/mw0pCwTUILYvsg777O0mWhrP2zhClyw4KU/QtL1Zr0Jtx+lfdH?=
 =?us-ascii?Q?w2IyRFtbyrGGQUG83ySJ/+sZROud35CywJSPJ1qF7nLGCz5MYZzV9j6gLRS4?=
 =?us-ascii?Q?LeMdMFUlZHAtmiIhKd0iFBH2tmdB/uqT6Os9uWiVZZ9MkM7ZhshIVhkJum6i?=
 =?us-ascii?Q?kl4AgFYTiCqyCbGDkf0qi147V2HbQ4tqLbeXYxvbizSA1p7sRMJeFoLXBK67?=
 =?us-ascii?Q?cSM6IBfZR6JsZ8NCTXwkwLaGfhgSeYaeKndmXDZJiZwe/zj9thgx/S3t3zv4?=
 =?us-ascii?Q?LzqRw+mIUiBhizHI8iQjq4v5mSszNOgUHppvWEizoWMn0myqgwBoATQ5Xmk+?=
 =?us-ascii?Q?Zmysg+UPacJ0rrxiHdTGv1hCq/dUckQpbcOzRJN2FR1Lyytjv+o+Xx6Vhjuk?=
 =?us-ascii?Q?WaCKgZMhGiqAE/CQgLXR6aDNgI5R1fzb+rkx1Bzl0TiYG2jC4zWrjXE20kYm?=
 =?us-ascii?Q?A1qBLiyasSs0lyhWVadyZbcq6mgk54f73kXPhHtQENBThPE0MlM/uJZQlQ9K?=
 =?us-ascii?Q?UXBySQTXsUbGvS8njfw8Pw0MNTihetIbRfMES7aIhd8Kg8NwK3KJFFs8Kef7?=
 =?us-ascii?Q?PqqQZFiWRKf5lzGsQ6g5yqkqqf/nIYmYZyaugUG/UxRofhzXNG+5onrdLKbk?=
 =?us-ascii?Q?oqA0FZLxviobElG3KYFogbg7iQtVcY/jJ6L19t2GxLGIgIuKHTciEg7PGoZC?=
 =?us-ascii?Q?yWIop52pdMG8RUfjbYRn+y556xxT3q74J/zoI57ZtQGA7/m28s9zXediBmm8?=
 =?us-ascii?Q?xuHnDeL8RQ79KmDemfymx1ZfYm0fyDuMYh0kZ8Tp1juqaiADLNpeJlni9uMm?=
 =?us-ascii?Q?5bLxjLrdspG0K9kwWRrquPqqgZfMN1mrryAPaa8ht3EOFE4DbafQMterYy5h?=
 =?us-ascii?Q?HOZ0UmbtsJYdM5+W5LlCrQ5eQn2aqCUYw5kLi1KuegBJKA/NB58bsh5lX2p5?=
 =?us-ascii?Q?UDfFfer2sNARqGHLOzgK5L7JZXgflI9xdn2IXAabrKMz9/H/B6nbO1Q0W2ja?=
 =?us-ascii?Q?qsDCsTCvImN/ZrCJDxpXY7W2UYeN2uQCAAJhur2mchpee0Cbhd+5dfRBuKpR?=
 =?us-ascii?Q?Ae1J7xqi6SGpqfboJz063LmDoLZ/8ZrV42crm37m5vkyhoZdExvkoknmkkO7?=
 =?us-ascii?Q?Jptm5Yijq98FFBsQ3ObpcwENe5gE/xbbhdC5uwqlisg4VbKsfeKlhlilz3wS?=
 =?us-ascii?Q?iX8PyNvK3uJ2MwsLURJ6OZ3GwFgsDEIAZV3r4JQ+kLmY0XvfdGEddG0j9wdT?=
 =?us-ascii?Q?GJEFE3GCtOGHDXicY1rmj/JaTuy7BWj9W2x/zI9cHEid3Ocr27+DjV8YI0mD?=
 =?us-ascii?Q?p8IsxoW9nxULUUGPqW+yQHPg9qdXUSumw+wsZH84vAcmiQD3FMQi98M7sm35?=
 =?us-ascii?Q?+5xRlWxiKpJmGsKnhcVH108iCL1GJHvw5smy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HHhs284W5W9rgVAyjNysmxaY2T0OqR6+sJxK5SQROasjyp0vuOMb8Yv65q4c?=
 =?us-ascii?Q?m+IS3KftFXHXlMWSNzudI+/LfOuUNAj3OFqrXxXFgDM+fver1Vv986YDC6L9?=
 =?us-ascii?Q?nlyIxTPrLK5QUc3DrGxHAkunA/pPIZ2VCqaXz/YVxmyCMh/7SztDaSOJq1yJ?=
 =?us-ascii?Q?iehHTa7/Vh+58wC85Xe2Uqo0ATL2T5J4YV6zVTpwjYtbiSWZXBzaQlRAdzaD?=
 =?us-ascii?Q?rUwwsxkxmwcgGP4xjM5thGo/avTNtK3o1Sgt7fwJNWA2ZHSzz0CrLHkiJiJg?=
 =?us-ascii?Q?Bp+41aUf0Z6r8ItkIJcjH61ZK3oZUU1X7g1CJI1Ra0QyXWzRSWFaqah1NwA3?=
 =?us-ascii?Q?Dkww3cd+fsCqMO7tUEpwdAia3cxCASGkaZgwplhDQsngYOiG76fNhLoA/i2S?=
 =?us-ascii?Q?NpWJc3G99v3YGE/tMKN9Jy7gtamB7EzoIN5ajjgnIM/BTHV4BqIjpxWJpYQ8?=
 =?us-ascii?Q?GdV9XRxOjP7txS6OBHthkCIVAz58NOBrVLuB5Wk2TacPfSG2HUWJqT4oiHSt?=
 =?us-ascii?Q?AwoiVJ9nUDyxm0ckHfSn/07m7MJ0cP2TpTCIg6WdAn4ys905Adw4DukRazGR?=
 =?us-ascii?Q?ta88M7zjBkGj7iUCAuS1N+QSh1pQFa6erbVemz/4c8l+lWDHnxWKyoor7xEd?=
 =?us-ascii?Q?AuuGitbaX/YNGeI0F5Gl22ft8nLW5ytd9w70NHZkrcolLWoTIocoj/AGn0G0?=
 =?us-ascii?Q?kGg+3KEQIU1LSD21FQhDGOJtyb9zh+SPANEjOE7OSUV3P/gUHCy7wZZtmEjB?=
 =?us-ascii?Q?sjzFX87v1JptDU6CLGZBpYKfhZ9Hp2xUeJLdmE5NJy7iDseKaPoKXyYHr4xM?=
 =?us-ascii?Q?X17y9XcJZHMjDZ48t8txwEXYZdL1YvEnmerI9GVKYzRa1ud3QPnPtLgQeXWs?=
 =?us-ascii?Q?rm8KoQRw+67B1+doW18UuvRqfRqypJ4XwadWyq2kjvVkvM2w70HJwPcn37e9?=
 =?us-ascii?Q?VpW3yNhjE1eVpDuxlxdgU3PnoejTjTxzFzZ2XRd7L5wjgkyxrJ52W6rDZkCL?=
 =?us-ascii?Q?6Jd2e2DEKhgWiJ4+qkmROxLBjFi/1xTjKX0zNbNCuYCHEKyfg9Iaityn/UDL?=
 =?us-ascii?Q?pyLK72izjuJONBXVUYrSwTJLQ7hEnjRoPooS+rZVlyzinR56+J5C8Rhcggpq?=
 =?us-ascii?Q?4eQwrSojOkXYmmyy6LqvQ4LkVKQDjJlXm75qNUDkzfgY4pRCPpAdPyIMtK80?=
 =?us-ascii?Q?qSm6O4mltGfRjIi9BU3INEiAAkLHpIeuDkhJHin/LEIHgAhxRQteiBsN02P/?=
 =?us-ascii?Q?zrM4jS576snW8+YkSb/s+VwLQTtoXREKtOGUa3t8j6D2I6pZaZGXZlGSloAt?=
 =?us-ascii?Q?/Beo9EW3JZX73u+V1UbYGlSEVj7Fc5wcJtQHkM+9nr54O1s2Oz0pM2StCGP7?=
 =?us-ascii?Q?GPfGqwPzMHf7RuQar4/8JdEsyXBkAJR8KcdVPLJRMswI9byoEQ9C6BUhh0Tb?=
 =?us-ascii?Q?zKLohpcB4Gyiq5oe/WwZ1/gfTQUvIuWTB3yVq5W7bqoyv/Oo7n2WkaLJj1j4?=
 =?us-ascii?Q?jQEI7Gumhxtl3mYxrzkktmX3tK6OTRYROJWQUNmipOJzdNHOwOSBgGB2F4yW?=
 =?us-ascii?Q?KULRdYPI6kkAo0U1inVxRBcMFfIHR0mtVI+2IfOtuEy/tue/XXQkXRPi+E9/?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef1bd71-aa5a-43ff-a87d-08de37f8cd1d
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 14:31:26.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzxnJmX2Lpa5V/oXn4BNosMLi3xkl0Ff42/nbPZwJt+q1KBSdq2B3qnhQ6cG9/Eeqnp5cnqdhHFJJK3XpPpRdp0F2pKLag8ON9gSP2t+9/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9314

Hi

I have an am335x board where the AINx channels are used for various
voltage/current measurement, i.e. they have a variety of current shunts
and voltage dividers in front of them. Describing those is pretty
straight-forward, and the resulting iio devices seem to work.

Now, I'd like to expose those as hwmon sensors, because there are other
i2c-attached ADCs on the board exposed that way, and it would be nice to
have them all available through "sensors" command in userspace. So
altogether, my .dts additions are

	ain {
		compatible = "iio-hwmon";
		io-channels = <&ain_12V 0>, <&ain_12V_i>, <&ain_3V3_i>, <&ain_Vin_i>, <&am335x_adc 4>;
	};

	ain_12V: ain-12V {
		compatible = "voltage-divider";
		io-channels = <&am335x_adc 0>;
		#io-channel-cells = <1>;
		output-ohms = <10000>;
		full-ohms = <110000>;
	};

	ain_12V_i: ain-12V-i {
		compatible = "current-sense-amplifier";
		io-channels = <&am335x_adc 1>;
		#io-channel-cells = <0>;
		sense-resistor-micro-ohms = <10000>;
		sense-gain-mult = <50>;
	};

	ain_3V3_i: ain-3V3-i {
		compatible = "current-sense-amplifier";
		io-channels = <&am335x_adc 2>;
		#io-channel-cells = <0>;
		sense-resistor-micro-ohms = <10000>;
		sense-gain-mult = <50>;
	};

	ain_Vin_i: ain-Vin-i {
		compatible = "current-sense-amplifier";
		io-channels = <&am335x_adc 3>;
		#io-channel-cells = <0>;
		sense-resistor-micro-ohms = <22000>;
		sense-gain-mult = <46400>;
		sense-gain-div = <1000>;
	};

[the fifth adm335x_adc channel is just to be used as-is, there's no
circuitry in front of that].

With this, running the 'sensors' command does produce sensible output,
but it also results in this splat:

  ============================================
  WARNING: possible recursive locking detected
  6.17.11 #5 Not tainted
  --------------------------------------------
  sensors/414 is trying to acquire lock:
  c1dc7b68 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_read_channel_raw+0x20/0x6c
  
  but task is already holding lock:
  c1dd2b68 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_read_channel_processed_scale+0x24/0xd8
  
  other info that might help us debug this:
   Possible unsafe locking scenario:
  
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
  Exception stack(0xe00b9fa8 to 0xe00b9ff0)
  9fa0:                   00000000 00000000 00000003 004639f0 00001000 00000000
  9fc0: 00000000 00000000 b6e80a7c 00000003 00000000 ffffffff 0046b1b8 bea555bc
  9fe0: 00001000 bea54f40 00000001 b6d89e6c

Just accessing a single property under /sys/class/hwmon/hwmonX/ also
results in a similar splat.

Am I doing things wrong, or is there a genuine problem hiding somewhere?

Rasmus

