Return-Path: <linux-iio+bounces-11098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8359AE4AA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 14:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9335CB225EA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 12:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687C91D5CF1;
	Thu, 24 Oct 2024 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Od3dps3r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE31D516C;
	Thu, 24 Oct 2024 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772505; cv=fail; b=AJ5EieKjoV2fKj7tOm16xpb6Tgb/lOSK2csqtJqtCvKAwujAhkNCHVKbOEzdKT+HYROdMY5crRcvJxahm0KN8dFE9J03dE3ThiiiBd3/eAI/Ju+rHFAfLa1sMMBZ7dtd/dwtFmzD/neLhGXCKxWWLSQGzN9TcDVHokSvjPGGTSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772505; c=relaxed/simple;
	bh=CqlcH9thuhpgPnpvkYvYk0lTWSVRXQoyroJfUgp5TnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OuiqLnvq3dKfAI52LPp5ToHKJ2sngTrlSt2awhxHI+BWDnWhVsTM7lqaLHRKFYMMgCMRMhMj7AFCCpIDDAJ7QQPqswAWpAg6sYGIXplV8vpEZQwONDdVYGuhHYwSnvepBqhoiZxoiSrb3dJaaOgSPiguo/kaF1eh/mvxcwWFlQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Od3dps3r; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NMoSmL022081;
	Thu, 24 Oct 2024 12:16:48 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazlp17012054.outbound.protection.outlook.com [40.93.78.54])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 42em2vhh6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 12:16:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KInayzSMKvOHAeZLTo4vUU1TmSBLLoOkSShScOvHr7O3ANIGJZZKqFqPRCtCPVUnQGBewkF+flLui9iR+vjiCUGBft0BaDrFsJy4rL+4cQJh38hxWJ/b++pjS61O9iWoPGWAwyv4Spkg+5CcCm5WLuQodFZc1qzLZU/s040kPewMhcwwrSvkjIRHUsxt2Tx+o2M7BX3N05u1Z0igTfkaP0++nmhw0358lixy2G3M7x74kpkHsx3xk+jeDSsddL24KG3xv06ldwFERP4EZeOLPt82xY4ks2ZSXbhY5CyPyOuBAtaxOUTtypMbXpgwLUHMowB6D+FA89qy05GZxj3+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ohEdin2/Y8WB+REE381AJTsIp9rAUaj05nwVfgUG+Q=;
 b=qUkHl9V5yXeNP9sNAELC1T/8RXQxzBLw4dn2puMUt3lVesQRgyTtlzGcjOdeMg3JDvQTiTtJY/3BnSpSA599c1KcKN1WrNnL51YuJjv2vo/JwlUHpRxsW6gj4wrdPGGbN9Ah4XBLNM9e6O21umO1BnwUi8Lz5dvPEwIHxK5VoblJjGiYfW2LI4342mihyo30LjV2AqjlZlsy6WefBINc+gJaAzkO+VWYx1sjkqD8cfUE8w4ox3fWx5PHZBWWSOdYMxL1LmMm8HplmMZuuFf3x9ATxyOtO3eNea9YCNq858VVbQxdIvS8LqNRPcLJiciyYXd78h7mYKcsv8qjyA5ttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ohEdin2/Y8WB+REE381AJTsIp9rAUaj05nwVfgUG+Q=;
 b=Od3dps3rtNZXUHbOS1toUNa36sK3QJ4nJuYyLF+dkn2aFCkvTsAMlGs0+KvsrZ4eC4R0JXsXh0lFIPu+xOzJ1vMa3087nvFRLTGXj4VbJ+DxWYgn92LPsfMAuTKYPcuWc88LRNeTzuNo/acMYMrpjBv1jqIuDtOBf3cMc30UH0g3Uz5vcaklySVgVNYJDIq9iLwiFUB5SW/7N4h7TVwfeaWW0uu/eiGsQkARY7ivl2h3txL1Gmtm5lO480NP3LeifmA5fBXj69zcvC0kFhU3jUFgtrLXbZsK59BQc5eVkdIdq+phtHLEQ7r/fHJIYV8h5KZnVXsau6zrTjdEU5O5pw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR6P281MB4305.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:12b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 12:16:43 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%6]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 12:16:43 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Julien Stephan <jstephan@baylibre.com>,
        Mudit Sharma
	<muditsharma.info@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>,
        Anshul Dalal <anshulusr@gmail.com>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Ramona Gradinariu <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Dan Robertson <dan@dlrobertson.com>,
        Marcelo
 Schmitt <marcelo.schmitt@analog.com>,
        Matteo Martelli
	<matteomartelli3@gmail.com>,
        Anand Ashok Dumbre
	<anand.ashok.dumbre@xilinx.com>,
        Michal Simek <michal.simek@amd.com>,
        Mariel
 Tinaco <Mariel.Tinaco@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Subhajit Ghosh
	<subhajit.ghosh@tweaklogic.com>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Linus
 Walleij <linus.walleij@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "chrome-platform@lists.linux.dev"
	<chrome-platform@lists.linux.dev>
Subject: Re: [PATCH 5/7] iio: imu: inv_mpu6050: simplify code in
 write_event_config callback
Thread-Topic: [PATCH 5/7] iio: imu: inv_mpu6050: simplify code in
 write_event_config callback
Thread-Index: AQHbJfTuj6ZJZW/nqEyVhpzdFj+5OrKVz92Z
Date: Thu, 24 Oct 2024 12:16:42 +0000
Message-ID:
 <FR3P281MB175799CC4895C8BC5B645236CE4E2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
 <20241024-iio-fix-write-event-config-signature-v1-5-7d29e5a31b00@baylibre.com>
In-Reply-To:
 <20241024-iio-fix-write-event-config-signature-v1-5-7d29e5a31b00@baylibre.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR6P281MB4305:EE_
x-ms-office365-filtering-correlation-id: 2d4ab813-56cf-4dd3-920f-08dcf425b8b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|3613699012|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dpde+LigFtUyZhuiGlrq14GU62dklV7TfD473aRd8Ig7UtLJwRo3QzKZFF?=
 =?iso-8859-1?Q?PTcnsWb22SeDaQiU8RwuJGwZeUTcb6O1Y8tQ+DoWSdi7iHQzONkSumRKe0?=
 =?iso-8859-1?Q?jgpA+9KaxOkInY9xLFZ3ImuAJHaTNeDhuNz39QQSio11fSm9LgTUVwFNUU?=
 =?iso-8859-1?Q?lIABqALhWcN0QddyJSAGMqeccNxBah+PxtcN7/rGuxX+4rtUmGQFFESfIc?=
 =?iso-8859-1?Q?8oliV1oEySANmqSchJpAN/FaSW3Z3XDvc7OXp9tqgUB0boj6RRNmEMgeds?=
 =?iso-8859-1?Q?BNufBjIlZOHdGZkaGzoDk6G6ANvVGtFxWCFQ2TcNyhscIaoxgTerbkvRez?=
 =?iso-8859-1?Q?1XhxKvDzAHRa90cXuugU5oNtdMy0P0nk/UwovKAs3gBcswX1T54KdxhOT3?=
 =?iso-8859-1?Q?2XowwapcLHm9/lOeJWIvixmzwVah79SHe9T31vZ99vIuJhXUUXREHOaapY?=
 =?iso-8859-1?Q?KrxfjL//fTB83koqewKnxmZdentGyAdW/fBQlVqs+DnjLKp2aFooY7UIdD?=
 =?iso-8859-1?Q?H8MVGflx/z4F0U9zqHBIva0C5NbA6SZho5c6zKnioaQZ9WNdLZiBMWGYDW?=
 =?iso-8859-1?Q?Mg6o4PxmR3wx1P4HviZ3i2sZhZnsa3FZBaXo8UGR+RSTigX9PSd/Z/Bbm6?=
 =?iso-8859-1?Q?ARJSOGHNlaCrzs09kRZa+Ua1bXR1e3+Qc64HLN+Ufz4tz0DcX9pL6SJU3y?=
 =?iso-8859-1?Q?y+sincZSqIagn/r0vp1OnpFyjT9NVGRy0Oou3z/2PdIVB4btUHlpG+WQFC?=
 =?iso-8859-1?Q?0kFdAX85L0W5aFv0BLSPCjaB+eJ67f82i4q9u8t7Mf5IJieWE5+MyeQloJ?=
 =?iso-8859-1?Q?poYdVPgzLTP51EY0VbJZBzv3ok8djt0gHc1rcwKH8MB/Nn8ZFTz6bepEMZ?=
 =?iso-8859-1?Q?X727gkjUrOSnjbk/a9nk+pNDN6KZafarF2YfGeQkMgYMhPKybJd7paLibQ?=
 =?iso-8859-1?Q?Cf9woOZwIMZJ2c9ux6nJrm46JndqeVsy6e0y+xNJ1bKUlp2mHa09E/eJXw?=
 =?iso-8859-1?Q?n4gfqk8IvZ7orluIuccot/hALDKFHIrkUCMdJyzvR7uvyRbp6vlZWKFeEx?=
 =?iso-8859-1?Q?M55GbKxshZWNrKkZPOirEYzdbWutoPS7cMVzuhCs8BvcsUnCZWzcqMWKQf?=
 =?iso-8859-1?Q?nwmyURjfRjady7uv5PrkBVIPm5jMk5QZ2FQJ/UVgoiKDLioSUQ6DHHz7qT?=
 =?iso-8859-1?Q?sQLe305n2Q176ZNo14Vaabilau40vxMY3r++aYN1+HeygzARGozMzbxCJY?=
 =?iso-8859-1?Q?Ni6FfmeR/YZ1z2coc7kVZGAhsXeF/mPBUoxAgBQvJ8mdG5JyGe27Lvzpmj?=
 =?iso-8859-1?Q?wZt+YyO8PcN+ZZwkuubihjNMDYqguo8ZXvaOk0Fh4j7LopFSkXRjoMFq89?=
 =?iso-8859-1?Q?/bZVO9WDWDVc0SpmbTA5yy5QN1inIluLSNX/9KadnZHAw5J3AvldUlTtNp?=
 =?iso-8859-1?Q?oEEEleo5cKfdNO+RoKLgyzM5m1GJeH31QSqbNw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(3613699012)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xqgmtRHI/arFLPdDxx+FlWCYGScQkFzHYn/ZezA3Lih/jAgPcnkn0XiGOA?=
 =?iso-8859-1?Q?TOwGHttaZYTnscDmRn0Jut4xaukILxyEb50wZKoYBPD2s3EDzBz3fwwMBZ?=
 =?iso-8859-1?Q?mKR/MiEzd9cYGGgWOGqmIQ1hsoQY+XudhYhGzQjVEfzH22ko4ZqglpXZJQ?=
 =?iso-8859-1?Q?M5Z2rRU1Fa8Rc5VeIR7jz6LR2+ZrFlhiWy1inyoBGNyvrKjKkJLhBExEeq?=
 =?iso-8859-1?Q?QhtwFD0jRp7sCRRSRxaR9qz/ho6w8zm6rSDSErK2DOgClw46i2NJNG2ry0?=
 =?iso-8859-1?Q?7xNWb1GVBlt0Zr2J7KImLg80a0KyKaQTUvgcHeD6o6Q7bw/Oq8IfEnTd/s?=
 =?iso-8859-1?Q?lJPISbxIee+TA4pTMzUrP53bYsWdfcN1PVf0+nPl2AQo3xfFbsmZtnurze?=
 =?iso-8859-1?Q?WftDV8CqnkAhoTa+QeqOGAwFcdSLBhzxb67BuQS8qTA+aqRH0PreekZAJ1?=
 =?iso-8859-1?Q?c+05GnSHp41au7TBrItaN3Nw0NKGKRFjez/ZxlXu0kf8aZ9aPvqsaWWZQh?=
 =?iso-8859-1?Q?PJoKh1vSzZ36uUVR5aD1me/cBFBlwPKtqFtBlKG+w3+wGN3oVuLEcJeu0G?=
 =?iso-8859-1?Q?IQNGSFtqVMo1no9XKmp9pKOwC6clEc48W6NVZ4IyfHZCCX+p3BPQ9PrC8+?=
 =?iso-8859-1?Q?x94BoNyxeewIxQ76kMNPvhRQbwQNlOw4gTw1XRC1O99YrX0uGsxjkRbWh1?=
 =?iso-8859-1?Q?IJz2Gvm1v5pBdr65vAAWh/b/txSza4fx4wHg8bwqtPEgCWz9C2Dbpzb+2d?=
 =?iso-8859-1?Q?+5yZPbVIZSAY4mhhK/4cINhhs3rlL/K5ibqt3f+g1/a9gcnaKtBnXD7Dyg?=
 =?iso-8859-1?Q?/i/8vh42NtZ8Pusn0vqlN8z+poKE0GmwXWr4AkZ5Slu3GnorvNj9Ff4QPT?=
 =?iso-8859-1?Q?rKU2XosQ43CTUWusYiR6nRfGERxCbquTqUqWyuByLBNgvH/tKmcIBDPCQV?=
 =?iso-8859-1?Q?E4AZcpTEVtf3VcfaVICF5quWIIS9ag7T8cxUttqH09xe81PmQfMlCi4jMf?=
 =?iso-8859-1?Q?xYNKr2ycGE/3vLqHDHZBamNqmOQGxNM6D3StNHQVAMVmktfyj4t/BZAc9w?=
 =?iso-8859-1?Q?buiMV3Gtqr05zmZlKGyG7Tx3yEks+UAxWtE4TxDyyLbWrIA6t6d0+F+sdw?=
 =?iso-8859-1?Q?L4gfBf7gcfCQybKbYbpVsrrkyuXmSgKY2LQcnNN7RRt0cpgROQQhE4zDIV?=
 =?iso-8859-1?Q?yiG1PkwkA74k8Kc+JdBSgAvq5VNo19WZ/tsKpX8j/eqg2oHgmYVvQqnSco?=
 =?iso-8859-1?Q?a9aK1LvA7WuHYb4uFMK1knb9ESWArpWm5YG+NpDvqOn53lsNwViali1dL/?=
 =?iso-8859-1?Q?oXi4ONJZs1U5O8qyw9R7RAAusJC9ORbgMJSl/Hj55T4DjAiKcb8npEOZXb?=
 =?iso-8859-1?Q?atyUuM+LlBBX9i8Hb5u27fITGYX7wxmq5loD5iS8JXzjvXPkqeOPQ5zPVO?=
 =?iso-8859-1?Q?au4ktAFuiQTF8Rlwmt3V67xEj+DUlD+majo/IONlByHN107Jo/1g3UCf5J?=
 =?iso-8859-1?Q?fawiwYhWBWIQZjL0BqRLmZuc65h8UbJCUfAjk6BXsisNjbDeZ5aI+5/6Fa?=
 =?iso-8859-1?Q?Hm7FVlwC9XX6nd8LqvBwAVSv/oQSpfIgXD6Ie5ET3OpPr3u4Lu0iZTyTGT?=
 =?iso-8859-1?Q?kTGqhLQDxZRqYBLaTJhBhEokWZsarMC/6tm/h1YFTv/+gxU+50R6Q8xNfI?=
 =?iso-8859-1?Q?T5qCX8arpc2dKxFjGM10yAhXXsgaHvPr0TmnzKADD7g+b3zYeVrE1N926h?=
 =?iso-8859-1?Q?SYeQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4ab813-56cf-4dd3-920f-08dcf425b8b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 12:16:42.9283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KOw0QYutIUVMVjFz+icBsEhFF0vDUvE+jdNoAW59RYRfPdVCDX6/ek05ZXbZ72OtzliEfJsFuamGFBXRM/Slu9QMrFqvDrad3B9t/QS61Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB4305
X-Proofpoint-GUID: J4nT5TsJCYIQhL3lQRDR-iNwZsgU3csy
X-Proofpoint-ORIG-GUID: J4nT5TsJCYIQhL3lQRDR-iNwZsgU3csy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240100

Hello Julien,=0A=
=0A=
good thing to know, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Julien Stephan <jstephan@baylibre.com>=0A=
Sent:=A0Thursday, October 24, 2024 11:11=0A=
To:=A0Mudit Sharma <muditsharma.info@gmail.com>; Jonathan Cameron <jic23@ke=
rnel.org>; Lars-Peter Clausen <lars@metafoo.de>; Anshul Dalal <anshulusr@gm=
ail.com>; Javier Carrasco <javier.carrasco.cruz@gmail.com>; Jean-Baptiste M=
aneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Michael Hennerich <Michael.Henner=
ich@analog.com>; Cosmin Tanislav <cosmin.tanislav@analog.com>; Ramona Gradi=
nariu <ramona.gradinariu@analog.com>; Antoniu Miclaus <antoniu.miclaus@anal=
og.com>; Dan Robertson <dan@dlrobertson.com>; Marcelo Schmitt <marcelo.schm=
itt@analog.com>; Matteo Martelli <matteomartelli3@gmail.com>; Anand Ashok D=
umbre <anand.ashok.dumbre@xilinx.com>; Michal Simek <michal.simek@amd.com>;=
 Mariel Tinaco <Mariel.Tinaco@analog.com>; Jagath Jog J <jagathjog1996@gmai=
l.com>; Lorenzo Bianconi <lorenzo@kernel.org>; Subhajit Ghosh <subhajit.gho=
sh@tweaklogic.com>; Kevin Tsai <ktsai@capellamicro.com>; Linus Walleij <lin=
us.walleij@linaro.org>; Benson Leung <bleung@chromium.org>; Guenter Roeck <=
groeck@chromium.org>=0A=
Cc:=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@v=
ger.kernel.org <linux-kernel@vger.kernel.org>; linux-arm-kernel@lists.infra=
dead.org <linux-arm-kernel@lists.infradead.org>; chrome-platform@lists.linu=
x.dev <chrome-platform@lists.linux.dev>; Julien Stephan <jstephan@baylibre.=
com>=0A=
Subject:=A0[PATCH 5/7] iio: imu: inv_mpu6050: simplify code in write_event_=
config callback=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
iio_ev_state_store is actually using kstrtobool to check user=0A=
input, then gives the converted boolean value to the write_event_config=0A=
callback.=0A=
=0A=
Remove useless code in write_event_config callback.=0A=
=0A=
Signed-off-by: Julien Stephan <jstephan@baylibre.com>=0A=
---=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 7 ++-----=0A=
 drivers/iio/light/apds9960.c               | 2 --=0A=
 2 files changed, 2 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
index 5680be153127711777b6074da18a7a0f86211d6c..21ebf0f7e28fec302cbf8ab890f=
c53a3de6f36cd 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
@@ -1176,21 +1176,18 @@ static int inv_mpu6050_write_event_config(struct ii=
o_dev *indio_dev,=0A=
 					  int state)=0A=
 {=0A=
 	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
-	int enable;=0A=
 =0A=
 	/* support only WoM (accel roc rising) event */=0A=
 	if (chan->type !=3D IIO_ACCEL || type !=3D IIO_EV_TYPE_ROC ||=0A=
 	    dir !=3D IIO_EV_DIR_RISING)=0A=
 		return -EINVAL;=0A=
 =0A=
-	enable =3D !!state;=0A=
-=0A=
 	guard(mutex)(&st->lock);=0A=
 =0A=
-	if (st->chip_config.wom_en =3D=3D enable)=0A=
+	if (st->chip_config.wom_en =3D=3D state)=0A=
 		return 0;=0A=
 =0A=
-	return inv_mpu6050_enable_wom(st, enable);=0A=
+	return inv_mpu6050_enable_wom(st, state);=0A=
 }=0A=
 =0A=
 static int inv_mpu6050_read_event_value(struct iio_dev *indio_dev,=0A=
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c=0A=
index 3c14e4c30805e1b596ef2380f94e6aa3e92082b1..3a56eaae5a68f2891d061871c70=
13f0b5447bb47 100644=0A=
--- a/drivers/iio/light/apds9960.c=0A=
+++ b/drivers/iio/light/apds9960.c=0A=
@@ -762,8 +762,6 @@ static int apds9960_write_event_config(struct iio_dev *=
indio_dev,=0A=
 	struct apds9960_data *data =3D iio_priv(indio_dev);=0A=
 	int ret;=0A=
 =0A=
-	state =3D !!state;=0A=
-=0A=
 	switch (chan->type) {=0A=
 	case IIO_PROXIMITY:=0A=
 		if (data->pxs_int =3D=3D state)=0A=
=0A=
-- =0A=
2.47.0=0A=
=0A=

