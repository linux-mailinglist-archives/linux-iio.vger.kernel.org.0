Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0256742ADCC
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 22:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhJLUaL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 16:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhJLUaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 16:30:11 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718E8C061570;
        Tue, 12 Oct 2021 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=5IE6qAD4wcr48hJHMkptfnkPZIoHalUtFis0kheqFLg=; b=orpSKoGhm84/S/Gbv6Lc1eP+35
        6wpajkgi4Gbx2ySUWgt7lJjUUgrbWdfHVjOplGAZ+oz+2jhB6bZ4PyGnYozVLJgCw65pOgwX0ZC6W
        5PHYPimqT1ztyyw2OOmC1ypeVi/v97uxprdVYJPSaCgYWZ096pyIjGKZl0gA0ME6wfh0nef5jNqet
        d7PKimwWTymmRrq7isUEKsaKeRdjE1m3FgqDCSSoRM2ANeKNqZv5eYn6RRvKsrVyKM6Uh7uYObcXY
        pPsX/r92tH0vaCCtjej8Vuojd5FFSg4F/ZU+mQhzlCisrDHEz+ic3tQcL6aL+k8ZqRIP0if+JV5Le
        jyx4megw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maONZ-00DvFt-KK; Tue, 12 Oct 2021 20:28:05 +0000
Subject: Re: linux-next: Tree for Oct 12 (drivers/iio/adc/imx8qxp-adc.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
References: <20211012204606.1dd72037@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <27c3f066-1926-db85-d183-d129a2ab43e8@infradead.org>
Date:   Tue, 12 Oct 2021 13:28:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012204606.1dd72037@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/12/21 2:46 AM, Stephen Rothwell wrote:
> Hi all,
> 
> News: there will be no linux-next release on Thursday.
> 
> Changes since 20211011:
> 

on x86_64:

../drivers/iio/adc/imx8qxp-adc.c:433:12: error: ‘imx8qxp_adc_runtime_resume’ defined but not used [-Werror=unused-function]
  static int imx8qxp_adc_runtime_resume(struct device *dev)
             ^~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/iio/adc/imx8qxp-adc.c:419:12: error: ‘imx8qxp_adc_runtime_suspend’ defined but not used [-Werror=unused-function]
  static int imx8qxp_adc_runtime_suspend(struct device *dev)
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~

# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set


-- 
~Randy
