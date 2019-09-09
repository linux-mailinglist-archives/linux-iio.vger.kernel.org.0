Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E932DAD419
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 09:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbfIIHqM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 03:46:12 -0400
Received: from mail-eopbgr710079.outbound.protection.outlook.com ([40.107.71.79]:4416
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388281AbfIIHqL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 03:46:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWSlHe+bN+AjmScG25PKHbk1SuxO4pn5wYGNWtUkbxOmvgeQUfyXAkD12ttzI7SijEExG4vIXQVyM5Fhtl4DYAXmIPx0IKSs9Z6wxC/qh787zw5irIkb3Pu2v5VObtzHXNx91LDDxGKs3lFNkA374wjiq1oGHmWPNqaoK4XhXUqJsDg9+h12AYHHQqYeGNyRW0jtbCwEO6Ma7JJ0i+lW05o0+DBb2PKlytat2fCqCjzRQRNjdsLQynIdYJInXB719fJ2xO6w0rxJrmUPRgVqGOe/CHrJT9x2TxFSmoh0doZHiz7EF359sqgcQKuOjIs/rJWd4po7HcXVV2/BrvXULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U3cxxzrUB/TDO4lsMgRvqdfxxuYQC14kXEUui2R/mQ=;
 b=GKefvikmOjGga1g11x0plR1F03pWNi8keueqclG6qGzKzFhWrmRxYveDaWozo+qwvCszwopakXIxZpIttAlpKyeMCMOfcRcZB/wOUsEciZR2GbxvWla+0MsCx+xxDZfk1TN40fRSntXattfjSz8oFlA5v9ieYVm1RHDtbwioojQFstpICN+9wj8EY+eoVJ6o2FNmiMDidb6wyf+bwx2BAr0IcdnJM1Whc1R9gpRTBOfMnbi/boLpp2bbjBOKff4ftQEU7AhDBN9Ckmw+PPzzqSPP10UHsPm/jjhbxmlNjsSwTCoQdfSfkm12SXJX4fCzZGNEze6llhsh17KqBjyXqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=electromag.com.au smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U3cxxzrUB/TDO4lsMgRvqdfxxuYQC14kXEUui2R/mQ=;
 b=K0aMbSajDAZuNmnGDvqSirNEL0LBs52eh8ZgfmVQ+qfjnAAEkIcOOmOjzSauZJrFcM4UzFlun04Ofw0g0QdxEBiw5PIRd3vPboHIXkjL7asiFMBv8aRigyJTiSrpOKy7KhyWiFBKc/VOLDsjZHrecsnIytKRiPTDqClTDSPvk7I=
Received: from MWHPR0201CA0096.namprd02.prod.outlook.com
 (2603:10b6:301:75::37) by DM6PR02MB5260.namprd02.prod.outlook.com
 (2603:10b6:5:51::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18; Mon, 9 Sep
 2019 07:46:06 +0000
Received: from SN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by MWHPR0201CA0096.outlook.office365.com
 (2603:10b6:301:75::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15 via Frontend
 Transport; Mon, 9 Sep 2019 07:46:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; electromag.com.au; dkim=none (message not signed)
 header.d=none;electromag.com.au; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT049.mail.protection.outlook.com (10.152.72.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Mon, 9 Sep 2019 07:46:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58627 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i7EN9-0007Ha-6I; Mon, 09 Sep 2019 00:46:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i7EN4-0006xG-26; Mon, 09 Sep 2019 00:45:58 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x897jpeD001909;
        Mon, 9 Sep 2019 00:45:51 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i7EMx-0006wb-8D; Mon, 09 Sep 2019 00:45:51 -0700
Subject: Re: [PATCH 2/2] iio: core: Add optional symbolic label to device
 attributes
To:     Phil Reid <preid@electromag.com.au>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com
References: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
 <1566876924-63608-3-git-send-email-preid@electromag.com.au>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <349d8473-7892-cf1d-519c-231cb91085d2@xilinx.com>
Date:   Mon, 9 Sep 2019 09:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566876924-63608-3-git-send-email-preid@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(2980300002)(199004)(189003)(31686004)(58126008)(316002)(230700001)(36386004)(52146003)(14444005)(23676004)(478600001)(31696002)(65806001)(65956001)(81156014)(5660300002)(8936002)(81166006)(8676002)(106002)(356004)(2906002)(9786002)(2486003)(6666004)(426003)(2616005)(44832011)(476003)(486006)(126002)(336012)(6246003)(11346002)(446003)(26005)(47776003)(229853002)(50466002)(70206006)(70586007)(186003)(305945005)(36756003)(76176011)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5260;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6753ab7e-8a14-4820-04b3-08d734f9c444
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR02MB5260;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5260:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5260DC536A5F5D5654C89D94C6B70@DM6PR02MB5260.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 01559F388D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xVk58YSSNvqVE+KcmnW6r/SAj4A4ypE1PRChCuPKyV8ybTQ2C9b13oo6JLzl6ZVWoyiuFa5yYM8/hyG0lUAHCcXnMR4ejsLQfnE1SvGQA9ArWmjzEsbWDsf6DaI4FakHVDKMMcHWRYYpFQnDH/eZjxotiY8b7vh0uHKOisDkFyl1GtUclfUdO84vaiUf8jbDizjgNzpy+HB6Hwe/HatIGlwKaVOJ/fxw4SK/IeWi0qcBB+Agry5yMb0PiAX7SSrnbiAz5znsOS9022NkLgf/SV2Q5rKOWazZ//O73ER2xoxBd21F8xZi4jCOUrBzIJAgBBLa6mV+7kwwR839MilX5Nof+f/dcQ3qkLc+2V29hWN3RkHxgWIgKJ0vVcoWBnM3eL9Y2b72kL/re11XMTjgYmpzEP5BdG7GyjRE02CX5mg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2019 07:46:03.6193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6753ab7e-8a14-4820-04b3-08d734f9c444
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5260
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 27. 08. 19 5:35, Phil Reid wrote:
> If a label is defined in the device tree for this device add that
> to the device specific attributes. This is useful for userspace to
> be able to identify an individual device when multiple identical
> chips are present in the system.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  drivers/iio/industrialio-core.c | 17 +++++++++++++++++
>  include/linux/iio/iio.h         |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 8303639963d7..2d7fb7629095 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1300,6 +1300,16 @@ static ssize_t iio_show_dev_name(struct device *dev,
>  
>  static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
>  
> +static ssize_t iio_show_dev_label(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	return snprintf(buf, PAGE_SIZE, "%s\n", indio_dev->label);
> +}
> +
> +static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
> +
>  static ssize_t iio_show_timestamp_clock(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -1416,6 +1426,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  
>  	if (indio_dev->name)
>  		attrcount++;
> +	if (indio_dev->label)
> +		attrcount++;
>  	if (clk)
>  		attrcount++;
>  
> @@ -1438,6 +1450,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  		indio_dev->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
>  	if (indio_dev->name)
>  		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
> +	if (indio_dev->label)
> +		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_label.attr;
>  	if (clk)
>  		indio_dev->chan_attr_group.attrs[attrn++] = clk;
>  
> @@ -1709,6 +1723,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
>  		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
>  
> +	indio_dev->label = of_get_property(indio_dev->dev.of_node, "label",
> +					   NULL);
> +
>  	ret = iio_check_unique_scan_index(indio_dev);
>  	if (ret < 0)
>  		return ret;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a74cb177dc6f..3f89db50d3f6 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -556,6 +556,7 @@ struct iio_dev {
>  	struct list_head		channel_attr_list;
>  	struct attribute_group		chan_attr_group;
>  	const char			*name;
> +	const char			*label;
>  	const struct iio_info		*info;
>  	clockid_t			clock_id;
>  	struct mutex			info_exist_lock;
> 

Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

