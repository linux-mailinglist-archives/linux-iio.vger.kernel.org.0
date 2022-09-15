Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D335B5B9D15
	for <lists+linux-iio@lfdr.de>; Thu, 15 Sep 2022 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiIOO2A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Sep 2022 10:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiIOO16 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Sep 2022 10:27:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54DBDF33
        for <linux-iio@vger.kernel.org>; Thu, 15 Sep 2022 07:27:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FDtrN3003550;
        Thu, 15 Sep 2022 14:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=EQ672QIUGwqtvG4e0G4+6WWqJzf+3Up0QMbTQDB32zY=;
 b=oV/+vIGu3AhW1mo6Mq+NsfR/xRisi2f958ajVxSDijtNYtIIIaTZOETOq2rSbFa6eHsO
 mySy+qzcWNgEjnF7Yvoru3f5inVgKaL5Ivhdl7KDRQH9DAnCBo8hEBr+xuCVEsKh80zx
 bzyPZ0NO8i32Hp+tdbZZjpoBmbV/0Pr9fikWW4sTRw1fOA5LMM7d9IzfoDRbIEnEl0E8
 US5hE+teuFAowfQ+8lcjLRVsfc0eRMAKFjjT+vrdFXahYLrQi4L3zbtKbO7QVruqxzqs
 oUIfw7jwNXWKEquH+UYDuWR4DHWsEpg96pNQjfnSLj4IGwp5fk+RBcal5KnTgfR67Jo7 ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxycdd82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 14:27:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FEBEGr037947;
        Thu, 15 Sep 2022 14:27:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjym625wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 14:27:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLSIrpgt3J3aK0JabI5UPueamN03RIwshkYpZ2l2KZdn0FxSADEV4sVF6/9cIe7mGuI9/D7B4zpMrS9Yon7zwvaroS3hHx89w2nIV3ON+oL42ov1aGvqMKsDcPXftPlTSrqibOJot98j4IRN9qt5z8/OvyC/JUSYyhK6yHpARo68jXbl7OF4zJvbwXwlOl8YNFCDHlKg5+mlnHyxkmGa3iqKgKY8y9NjGMw6/SRy9FEX69ZQYExklI8TzK4TSKLXTAWKfAAYW8NA0mwKXMYcMAVDqFCbtnS4Cl4rX++jcj9wooODNHJCtKpvsem5qqOv2S6iPhQbTPKlfmzHaLwdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ672QIUGwqtvG4e0G4+6WWqJzf+3Up0QMbTQDB32zY=;
 b=YJWdOgpm6F22DQd8p6iFqRPRfreioX+XUlhuAw609G/h4wSV69y23CbZRjS6SmRrmi3g8spB1zTiLHbOE6ahCXsS5FkUnrrXlAsxtnLjaCm1TGpeNjud0+rzXY9s+LCe52O1KSbuVVG6cAXKxdCMJyCh1mZkqSyQoowqkVNKhGoXMHidkeG+WQodrwIZhY6DC/MVQm8fhj/Z703wNcEFSs9jodcE6G5X7HAvlIMKhSz24ETXlyaDXXg1KmgAzD5v9CfBKgfdatXqewUz2ceXYmpEA2ze1UkYb3/3o+hjgQRd5jF/D3gCEOUM+u9dhHnvjh9OfPpp+oz6+mnu1T8log==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ672QIUGwqtvG4e0G4+6WWqJzf+3Up0QMbTQDB32zY=;
 b=lwd9heVuA1twIKBVQv1zlYpj7GqJwG/cCRC4dXqvE+MV7THgQhYAcgr822Bflz6hQMXzF4OPQiwSYaoTFX5K+cO1W3DyVzXEkSukdzjW1HkqnfIFC3jbHiSonUldjlFbhiRUXNMhQxOmIfW83sJrrPnj9iHP5wxgedrIc2pJ4uk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY5PR10MB5962.namprd10.prod.outlook.com
 (2603:10b6:930:2d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:27:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 14:27:49 +0000
Date:   Thu, 15 Sep 2022 17:27:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     jagathjog1996@gmail.com, Alexander Potapenko <glider@google.com>
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] iio: accel: bma400: Add support for single and double
 tap events
Message-ID: <YyM2X3SbeD2ZYoKu@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0118.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CY5PR10MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: e6eea979-a0b7-46f9-fbe4-08da9726775f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDFdsoxCK84+Ov3C9AmWrApTdXHHZ9kfQS+ZRbTrS7IvfdnjoWMzx0X9I0HOLuW/ATdH1LxFLcEQq1t8deVI5bIaYV9C8NL3LXRD77yE9TY7vJTdb7z8h6FdGWTFdY0ROvZjyYRtt4BtIt81x3bSrNZJow88/zBBkORYABcLPhgVoCurB9sV/aqO69cY/AYhFH5jLHpYa3CTonh/tiAryloa05UBBq2M8j1Bge5wFyo9XhmlGKiWxHK5AdLDZjTcJXih1uo/gtck/MiBGaI9T+YR0qTLIz+pMOgzde3V0klh8c9m5jiyXUiyQP65pO3YzkYS3LfVUQorGLt47k56exBwXOyPLHjBkvsy7xAedW/AWMxK9tIQyRumEd3bXwQBRf5Z+swgA9Ifzk+xulObwQZjYYOlcpQBqioegB1fMAerfd6c8K5sU6AN08aNS6b4TSabo5TibINMJPacfOwyMUSiGmM9/aAM0AWz7TIPq19Z/VL/QVtfO7r0Mc9AsYVF+4e3OsRDcGMQTTrpAsckBycjeUb4BeKC8aBQV6MnT2k9VRWCTKjqZ+xpdWAy0VJfXOeX0lBT8j3Nz+bc2DqbcglCkMbRPi+0c3HvVWuR9oAnblgdtT2IRxi8lSFua9O1CUw1QX9PoCz4rJGJ7xnGmmN1C2JL+DsGBbZZVlubJq7iS4HWj3Y0V9gm1HkqhAo2/Ct+yPDrAi1rOaBlnUEfag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(26005)(5660300002)(66476007)(66946007)(4326008)(316002)(8936002)(38100700002)(41300700001)(83380400001)(8676002)(6512007)(44832011)(6666004)(9686003)(33716001)(66556008)(478600001)(86362001)(6916009)(186003)(2906002)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZH4b/44N5s907h0zZE3G992qUmuoIboa1SFEz9dsMBN+1JKyR6TsAPqvda86?=
 =?us-ascii?Q?kLzOJYOixIV+VflBYlE8/ye2HRrUl8ljiKrtILAGyYqcKKD3O8KEwV+mGKbd?=
 =?us-ascii?Q?s+oyoAAHivb5uEOaHyTcYFOL5jCKpaLha9jdgr8Q/KBqMqcbE8woXsbI+k3c?=
 =?us-ascii?Q?R5TAttNHfKkZEFjRD9WmJP4DkLUCDsCBEPP+t+qDK+fqdk74ZRkpUYscMlpG?=
 =?us-ascii?Q?KGnREioog7B8Yu61QXocfc827732XNwtI/FHy1t+qDfYkPQSw4XkxqB5K/dw?=
 =?us-ascii?Q?985KWIx3ipmJrN38TokgI0gRrmgF/zup5g5NX4QiItgqu2xlOrbDsnsnC+Nm?=
 =?us-ascii?Q?YyD3SaXaoEts2VOLfBxA4oK1Eli5ZWOlcQyLxlwSyXuKyGUshvBdsm9geUP6?=
 =?us-ascii?Q?hQJuzWdweECMYD/HoJUekLZEABY+9pui56ZFMAq9qZuFG55rTKv5PIEpl4F/?=
 =?us-ascii?Q?IzOfDYX4BXR/ZajueF9R9p9FsQlHSDy7pVu5ub3Sj3FpKUhbb5Vsiz4blyPp?=
 =?us-ascii?Q?RTqg0rkPip3gnXcvAurrZyYlLC9N0a771D2EI8Hw47OqXYqkZ3VU1YSLO1D0?=
 =?us-ascii?Q?MZMS92ktnqkSPC74fIOA4GDqiGg9xl31+CxgV5ek5Dt1cB7HuVmYJ+iOgBEP?=
 =?us-ascii?Q?E6jDycAksKhNXXaWn/0cjQJlZUpRQnsEyHupFqFEbaf2bQvVan/zgGyq2FWS?=
 =?us-ascii?Q?uC9lUui0yAXa0evmBz3/jMANPuWiaEEyfr+0yElqeWjDIdsU1eZNR8SDybu5?=
 =?us-ascii?Q?oI/fv8LdT9tN2ml8BMbexvIjOvkOCJ/MBgTAgybTUzBBxgUnEmaiIN2zlUvO?=
 =?us-ascii?Q?BNRMmHeMarrTdKzB3EDWJ2UEmTpfmyX45k1ehE8XRk6dF4bX8m8mMRhWxyyt?=
 =?us-ascii?Q?v4bUQP8ISs4sw5UiNIQxUe4nxFqRSX3NtaNHQdaQ+d24l4tFjA9Cun8aE1Rv?=
 =?us-ascii?Q?eoDTroaNjVaE81fOhQZVIo6zRAr0cyAJzLVymnh8oFwPlpdrLl6aS8IwQNnh?=
 =?us-ascii?Q?e69pQETkvJIYYL+zq00j9frTE9r4LnGq4rKYZiyx2B7/+pqClLBlem3eD60d?=
 =?us-ascii?Q?i7YBrg8mUDmBMjH6n24uxhFPiZVdgtuZbgcFHunWTFOMFsdo7WphyezsZWyN?=
 =?us-ascii?Q?Y0ISLBDFiRfuMn5hu+1uUNZFnr7yWk4HzFQ2ZaDqvpehM+YhgirXwXOy2P+G?=
 =?us-ascii?Q?LsEPgLmRQpzPefO9RFFHkMQk8WvDdGxZjCtFCSCJHUQWIny43BWx1O5yYyhw?=
 =?us-ascii?Q?iq0PsDdt9oSlFkJ20ESYcg9ux0gB8oly1RvC00KxDFvEJaD5kbVomKOreTTD?=
 =?us-ascii?Q?/uWx5V31d2MoRcbs/nGxItjl0StqNrA2ttHZc0rg+eff+gNkn1b1kuqSzt6Z?=
 =?us-ascii?Q?l9OOq56vH5Mw/iupudQZQzQDoqcwfnwkh6Qgi1xewyq2jQpq6WnthK0/7f1z?=
 =?us-ascii?Q?pgYuwT7i8Fwr3RBTJBCeFsgDOgN3dt/4n5cbVYICc+PumKIog7zsc1dw9qEW?=
 =?us-ascii?Q?xJs2FAqb/1eG/t4fMuwqHyZMDaT+sB+4JBhGPQLK7CzYo9+gSpwYcgizfInv?=
 =?us-ascii?Q?+npEF089HFwaCIb/mPDjc+ax1MdmMGJbAJxitOQ/WoeFd5Vcxp3MTIpWm+IS?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6eea979-a0b7-46f9-fbe4-08da9726775f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 14:27:49.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDfESiwxdUj+0x2x1NRY5El8Hy8ee2iQr5yos9eSRhpTyCva/aPI99qX3TbZ6gjCsNZXSXDRLeY1Psa8KGdBikDZet4u0eRiKRLgb5BEoeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150084
X-Proofpoint-ORIG-GUID: ZmQ7_1kI_ZnvAfxZYwkhfAPR9C1WmJtM
X-Proofpoint-GUID: ZmQ7_1kI_ZnvAfxZYwkhfAPR9C1WmJtM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jagath Jog J,

The patch 961db2da159d: "iio: accel: bma400: Add support for single
and double tap events" from Aug 31, 2022, leads to the following
Smatch static checker warning:

	drivers/iio/accel/bma400_core.c:1287 bma400_tap_event_en()
	error: uninitialized symbol 'field_value'.

drivers/iio/accel/bma400_core.c
    1242 static int bma400_tap_event_en(struct bma400_data *data,
    1243                                enum iio_event_direction dir, int state)
    1244 {
    1245         unsigned int mask, field_value;
                                    ^^^^^^^^^^^^
This is uninitialized.

    1246         int ret;
    1247 
    1248         /*
    1249          * Tap interrupts can be configured only in normal mode.
    1250          * See table in section 4.3 "Power modes - performance modes" of
    1251          * datasheet v1.2.
    1252          */
    1253         if (data->power_mode != POWER_MODE_NORMAL)
    1254                 return -EINVAL;
    1255 
    1256         /*
    1257          * Tap interrupts are operating with a data rate of 200Hz.
    1258          * See section 4.7 "Tap sensing interrupt" in datasheet v1.2.
    1259          */
    1260         if (data->sample_freq.hz != 200 && state) {
    1261                 dev_err(data->dev, "Invalid data rate for tap interrupts.\n");
    1262                 return -EINVAL;
    1263         }
    1264 
    1265         ret = regmap_update_bits(data->regmap, BMA400_INT12_MAP_REG,
    1266                                  BMA400_S_TAP_MSK,
    1267                                  FIELD_PREP(BMA400_S_TAP_MSK, state));
    1268         if (ret)
    1269                 return ret;
    1270 
    1271         switch (dir) {
    1272         case IIO_EV_DIR_SINGLETAP:
    1273                 mask = BMA400_S_TAP_MSK;
    1274                 set_mask_bits(&field_value, BMA400_S_TAP_MSK,
                                       ^^^^^^^^^^^^
Smatch ought to print a warning here but these macros use a bunch of
*(&(*(&field_value))) permutations that confuse Smatch.  Smatch does
not print a warning if you're just taking the address of a variable.

This initializes BIT(3)?  I believe that KMSan will detect this as a bug
an issue a warning here.

    1275                               FIELD_PREP(BMA400_S_TAP_MSK, state));
    1276                 break;
    1277         case IIO_EV_DIR_DOUBLETAP:
    1278                 mask = BMA400_D_TAP_MSK;
    1279                 set_mask_bits(&field_value, BMA400_D_TAP_MSK,
    1280                               FIELD_PREP(BMA400_D_TAP_MSK, state));
    1281                 break;
    1282         default:
    1283                 return -EINVAL;
    1284         }
    1285 
    1286         ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG, mask,
--> 1287                                  field_value);

This uses BIT(3).  The function only cares about BIT(3) but the other
bits are uninitialized.

    1288         if (ret)
    1289                 return ret;
    1290 
    1291         set_mask_bits(&data->tap_event_en_bitmask, mask, field_value);
    1292 
    1293         return 0;
    1294 }

regards,
dan carpenter
