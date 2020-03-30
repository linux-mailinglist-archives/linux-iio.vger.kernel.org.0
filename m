Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A9F1973B9
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 07:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgC3FNI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 01:13:08 -0400
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:6125
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728120AbgC3FNI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Mar 2020 01:13:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ndt/h8iT1zGsqfB3wBnfn9RHhpkmJWW437op6PNJbP65TyiLYhHY03VcISQoOQZW5N2VUxmnPoka/bNlz4ww91RulqJ7L2zOeaCfuoQGL9ZSUOXk3WpZcnDZnZtGziliV1GGRASpbwt7izVXboFsBUmx4g430F5iO7Klp0VaCgU7gJ/6noMaMvdJ7/nbknivyj/C5hOLMMqEEdvQH/g6mozBHOzp93SloIsLVQtS/RntP/oMQzmbk2caJhu8FCtMOpb9HazeeVfvgKosG3h853rKGxeu7dFctV57Kk8nuGGc0PqNRh9iklPzRbTxFxOYnbpIQaTY55DsZkiNRytUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO3bJC6AYrjR1B7XL8YSVmznQLoHNmz5Ykbxf7ZHSRo=;
 b=hr9lWNGkwLfL/IDYR+1KK2Aa8j910HgzkSWr0VPGDIzDxVYupXnrIc7B34laP88BxkVf6KVxFR3b9ze+o6uv2p7vgjYMPrgzYnmg98ROeCKwPNtBztCcq0UAG8+v7yaUo+L0eD0sEACztUVUMOFxe5OIh10lpwK9PrmACcNq1aqwHIeasbOInhMWNXlxJsqOKLcRI4Y6QdWmTenxX9LAkPntumwMPfvHj9KwOqU7+tSGPnGeAqssJFJOc3O0DpiCtwvS5nvoJ6ojOjXSoAz5FR/Nx11BfuglbegrZVlYHlC4b2n3qUfWHdXL4PtMij4qdOJEOquwLO8/+7NUls09sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO3bJC6AYrjR1B7XL8YSVmznQLoHNmz5Ykbxf7ZHSRo=;
 b=LIK2hUOBBh/LKGSEGyZpDibflb6gTndA3vDZENqiH1wI7fVQKCW+OQ8nZhyI8e2mphp+ST80sKOh5wYD4tfEvGPJIn4V5/AxzQ4NqfXuVK/pRh4GuuiZRQ8yF4iEZ1w6JAFPRuTlgWZ+uKGE9bvHqOoK9hUAuZV8nhOKNFdUZWE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Mon, 30 Mar
 2020 05:13:03 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::61e1:6a43:d8b:f7a4]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::61e1:6a43:d8b:f7a4%6]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 05:13:03 +0000
Subject: Re: [PATCH v4 2/4] SFH: PCI driver to add support of AMD sensor
 fusion Hub using HID framework
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com
References: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
 <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
 <CAHp75VcTnZzf9_=ftO=+LbSx3v5FWqVq5RJ=FW32z2FPCnYbsw@mail.gmail.com>
From:   "Singh, Sandeep" <ssingh1@amd.com>
Message-ID: <f5311f8f-e843-002d-5e2f-2b23e6f82707@amd.com>
Date:   Mon, 30 Mar 2020 10:42:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <CAHp75VcTnZzf9_=ftO=+LbSx3v5FWqVq5RJ=FW32z2FPCnYbsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN1PR0101CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::33) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.218] (165.204.159.242) by PN1PR0101CA0023.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 05:12:58 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce9364c9-76e8-4321-6780-08d7d46905f2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3640:|BYAPR12MB3640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB364034E2DEAC29475AFEF83BE0CB0@BYAPR12MB3640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(956004)(478600001)(54906003)(2616005)(2906002)(31686004)(110136005)(4326008)(53546011)(66476007)(26005)(66556008)(16576012)(6666004)(8936002)(66946007)(5660300002)(8676002)(36756003)(16526019)(81166006)(81156014)(186003)(6636002)(316002)(52116002)(6486002)(31696002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CcGXMRw2ApGnzVKSnaI4sAYy0wSaiCxBJX6xcDyCLpT/0beJp9gjDQfn52Le0veGM34BdYIaCknwyxxSz0qUum7kN5VLa/0jPkRl1X+/pHK0SFmlA1dbYcXrjJN9QTQwpP0Px+kBVCA9rkRf+e6p3rEa9i/qB3hnV3pG+o6ehvCMRj5J/pSt0/9ONp1Pb0FhH1JAoecesysqLcJHE2V/H0y3hK+Irf9JrAh4db/qBjZSfpEAm3FDPnfNUlqN7G3GeQOPH0F3qP38rXYqjHd+BsdVxfJOPdg58B7Lx7w42f4PUi3ZxKJyxLf+8ZkCKaTfsZe1dB9xpUwVWI1c+1xGC3VeKEZW4tsipdgi7XgRq51YDxL5SyoFeyGy84q9da8W5WvsyIcZEdabwksTyATcZzU8n5japD/+jhUN+6ydMYEy9a8u2WaUwIyERFdhy+wO
X-MS-Exchange-AntiSpam-MessageData: bmsNoJTKlb30CL6PzS2DyUIuEkxG64fLDC5QmAZ6D/q/dFAEWT5aeoWdnutuuvDeBRlsZrzE4MgWL43yv99J7Aq0yplQxGnvPK7kzxK6fESRmIkqbrked93Y7RxHeS+4fPOajXX0D65Rck9EUGwf8g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9364c9-76e8-4321-6780-08d7d46905f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 05:13:03.8108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nECdmkHuYo+mRc2uHP4azr3IIn+H6qQWxEScbCW0w55CTDOBuX53YF6A6KZOeKgH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3640
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks Andy for review comments i will look into it.

On 3/27/2020 8:25 PM, Andy Shevchenko wrote:
> [CAUTION: External Email]
>
> On Thu, Feb 27, 2020 at 7:01 AM Sandeep Singh <Sandeep.Singh@amd.com> wrote:
>> From: Sandeep Singh <sandeep.singh@amd.com>
>>
>> AMD SFH uses HID over PCIe bus.SFH fw is part of MP2
>> processor (MP2 which is an ARM® Cortex-M4 core based
>> co-processor to x86) and it runs on MP2 where in driver resides
>> on X86. This part of module will communicate with MP2 FW and
>> provide that data into DRAM
> You asked for review, here you are.
> TL,DR; it requires a bit of work.
>
> ...
>
>> +       depends on (X86_64 || COMPILE_TEST) && PCI
> For better maintenance
>         depends on X86_64 || COMPILE_TEST
>         depends on PCI
>
> ...
>
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Makefile - AMD SFH HID drivers
>> +# Copyright (c) 2020-2021, Advanced Micro Devices, Inc.
>> +#
>> +#
> Perhaps simple blank line instead?
>
>> +ccflags-y += -I$(srctree)/$(src)/
> Why?
>
> ...
>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/slab.h>
>> +#include <linux/delay.h>
> Keep in order?
>
> + blank line?
>
> Missed bits.h, types.h.
>
>> +#include "amd_mp2_pcie.h"
> ...
>
>> +       write64((u64)info.phy_address, privdata->mmio + AMD_C2P_MSG2);
> Why explicit cast?
>
> ...
>
>> +       /*fill up command register */
> Space is missed.
>
> ...
>
>> +       if (!sensor_id)
>> +               return -ENOMEM;
> I can say -EINVAL as per its definition, but why do you need this at all?
>
> ...
>
>> +static int amd_mp2_pci_init(struct amd_mp2_dev *privdata, struct pci_dev *pdev)
>> +{
>> +       int rc;
>> +       int bar_index = 2;
>> +       resource_size_t size, base;
>> +       pci_set_drvdata(pdev, privdata);
> Better to assign when you are sure (to some extend in both of them):
> a) it's needed
> b) driver is going to be probed correctly
>
> ...
>
>> +       rc = pcim_iomap_regions(pdev, 1 >> 2, DRIVER_NAME);
> What 1 >> 2 means? Shouldn't be simple BIT(2)?
> How was this been tested?
>
>> +       if (rc)
>> +               goto err_pci_regions;
> ...
>
>> +       base = pci_resource_start(pdev, bar_index);
>> +       size = pci_resource_len(pdev, bar_index);
>> +       dev_dbg(ndev_dev(privdata), "Base addr:%llx size:%llx\n",
>> +               (unsigned long long)base, (unsigned long long)size);
> Read printk-formats.rst.
> Now, when you get familiar with it, find proper specifier and drop
> these ugly castings.
> But wait, why do you need this? `dmesg` will show it anyway during
> boot / hotplug event time.
>
> ...
>
>> +       privdata->mmio = ioremap(base, size);
>> +       if (!privdata->mmio) {
>> +               rc = -EIO;
>> +               goto err_dma_mask;
>> +       }
> Why?!
>
> ...
>
>> +err_dma_mask:
>> +       pci_clear_master(pdev);
>> +err_pci_regions:
>> +       pci_disable_device(pdev);
> Are you using devres or not? Please, be consistent.
>
>> +err_pci_enable:
>> +       pci_set_drvdata(pdev, NULL);
> I think it's some like 5 to 10 years that we don't need this.
>
>> +       return rc;
>> +}
> ...
>
>> +       pci_iounmap(pdev, privdata->mmio);
>> +
>> +       pci_clear_master(pdev);
>> +       pci_disable_device(pdev);
>> +       pci_set_drvdata(pdev, NULL);
> Ditto as above two comments.
>
> ...
>
>> +       dev_info(&pdev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
>> +                (int)pdev->vendor, (int)pdev->device, (int)pdev->revision);
> Oh, if you use explicit casting for printf(), 99.9% you are doing
> something wrong (in kernel space).
> On top of that, why this noise is here?
>
> ...
>
>> +       privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
>> +
> No need for this blank line.
>
>> +       if (!privdata) {
>> +       }
> ...
>
>
>> +       rc = amd_mp2_pci_init(privdata, pdev);
>> +       if (rc)
>> +               goto err_pci_init;
>> +       return 0;
> Why its content can't be simple here? I.o.w. why this function is needed?
>
> ...
>
>> +err_pci_init:
>> +       return rc;
>> +err_dev:
>> +       return rc;
> Completely useless code.
>
>> +}
> ...
>
>> +static const struct pci_device_id amd_mp2_pci_tbl[] = {
>> +       {PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2)},
>> +       {0}
> 0 is not needed, but it's up to you.
>
>> +};
> ...
>
>> +static int __init amd_mp2_pci_driver_init(void)
>> +{
>> +       return pci_register_driver(&amd_mp2_pci_driver);
>> +}
>> +module_init(amd_mp2_pci_driver_init);
>> +
>> +static void __exit amd_mp2_pci_driver_exit(void)
>> +{
>> +       pci_unregister_driver(&amd_mp2_pci_driver);
>> +}
>> +module_exit(amd_mp2_pci_driver_exit);
> module_pci_driver()
> We have it for years.
>
> ...
>
>> +#include <linux/pci.h>
> I don't see users of it, but missed headers
> types.h
>
> ...
>
>> +#define PCI_DEVICE_ID_AMD_MP2  0x15E4
> Why it's not in C file?
>
> ...
>
>> +#define AMD_P2C_MSG0   0x10680 /*Do not use*/
>> +#define AMD_P2C_MSG1   0x10684
>> +#define AMD_P2C_MSG2   0x10688
>> +#define AMD_P2C_MSG3   0x1068C /*MP2 debug info*/
>> +#define AMD_P2C_MSG_INTEN      0x10690 /*MP2 int gen register*/
>> +#define AMD_P2C_MSG_INTSTS     0x10694 /*Interrupt sts*/
> Missed spaces.
>
> ...
>
>> +#define write64 amdsfh_write64
>> +static inline void amdsfh_write64(u64 val, void __iomem *mmio)
>> +{
>> +       writel(val, mmio);
>> +       writel(val >> 32, mmio + sizeof(u32));
>> +}
> NIH of lo_hi_writeq().
>
>> +#define read64 amdsfh_read64
>> +static inline u64 amdsfh_read64(void __iomem *mmio)
>> +{
>> +       u64 low, high;
>> +
>> +       low = readl(mmio);
>> +       high = readl(mmio + sizeof(u32));
>> +       return low | (high << 32);
>> +}
> NIH of lo_hi_readq().
>
> ...
>
>> +struct sfh_command_register {
>> +       union sfh_cmd_base cmd_base;
>> +       union sfh_command_parameter cmd_param;
>> +       phys_addr_t phy_addr;
> Are you sure? This type is flexible. And by name of the struct I think
> it operates with hardware, so, fix it accordingly.
>
>> +};
> ...
>
>> +enum response_type {
>> +       non_operationevent,
>> +       command_success,
>> +       command_failed,
>> +       sfi_dataready_event,
>> +       invalid_response = 0xff,
> GENMASK()
>
>> +};
> UPPER CASE?
>
>> +enum status_type {
>> +       cmd_success,
>> +       invalid_data_payload,
>> +       invalid_data_length,
>> +       invalid_sensor_id,
>> +       invalid_dram_addr,
>> +       invalid_command,
>> +       sensor_enabled,
>> +       sensor_disabled,
>> +       status_end,
>> +};
>> +
>> +enum command_id {
>> +       non_operation = 0,
>> +       enable_sensor = 1,
>> +       disable_sensor = 2,
>> +       dump_sensorinfo = 3,
>> +       numberof_sensordiscovered = 4,
>> +       who_am_i_regchipid = 5,
>> +       set_dcd_data = 6,
>> +       get_dcd_data = 7,
>> +       stop_all_sensors = 8,
>> +       invalid_cmd = 0xf,
>> +};
> Ditto.
>
> ...
>
>> +enum sensor_idx {
> Do you need names for enums like this?
>
>> +       ACCEL_IDX               = 0,
>> +       GYRO_IDX                = 1,
>> +       MAG_IDX                 = 2,
>> +       AMBIENT_LIGHT_IDX       = 19,
>> +       NUM_ALL_SENSOR_CONSUMERS
>> +};
> ...
>
>> +struct amd_mp2_dev {
>> +       struct pci_dev *pdev;
>> +       void __iomem *mmio;
> Header for __iomem?
>
>> +       struct delayed_work work;
> Header for this?
>
>> +       void *ctx;
>> +       void *cl_data;
>> +};
> ...
>
>> +struct amd_mp2_sensor_info {
>> +       u8 sensor_idx;
>> +       u32 period;
>> +       phys_addr_t phy_address;
> Same comment as per above use of phys_addr_t type.
>
>> +};
> ...
>
>> +#define ndev_pdev(ndev) ((ndev)->pdev)
>> +#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
>> +#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
> Why? What's the benefit?
>
> --
> With Best Regards,
> Andy Shevchenko

Regards

Sandeep

