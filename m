Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB872C4FF
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2019 13:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfE1LAE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 May 2019 07:00:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5043 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726305AbfE1LAE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 May 2019 07:00:04 -0400
X-UUID: 37ca587f27c944d28c789b064b80d225-20190528
X-UUID: 37ca587f27c944d28c789b064b80d225-20190528
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1074950528; Tue, 28 May 2019 18:59:58 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 28 May 2019 18:59:56 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 28 May 2019 18:59:56 +0800
Message-ID: <1559041196.12867.3.camel@mtkswgap22>
Subject: Re: [PATCH 3/4] iio: adc: mediatek: SET_LATE_SYSTEM_SLEEP_PM_OPS
 support
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <peter.wang@mediatek.com>, <kuohong.wang@mediatek.com>,
        <jg_poxu@mediatek.com>, <stanley.chu@mediatek.com>
Date:   Tue, 28 May 2019 18:59:56 +0800
In-Reply-To: <7838dcae-8a69-0297-718b-a061b14a456d@gmail.com>
References: <1557994247-16739-1-git-send-email-chun-hung.wu@mediatek.com>
         <1557994247-16739-4-git-send-email-chun-hung.wu@mediatek.com>
         <20190518113527.5210b0bf@archlinux> <1558332205.11080.6.camel@mtkswgap22>
         <7838dcae-8a69-0297-718b-a061b14a456d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Matthias:

  Thanks for your suggestion, I think device_links is a good way to
make dependency of module's suspend/resume order.

Hi Jonathan:

  Is it ok to keep using late_suspend and early_resume, or do you think
it's better to use device_links?

Thanks,
Chun-Hung
On Wed, 2019-05-22 at 18:28 +0200, Matthias Brugger wrote:
> 
> On 20/05/2019 08:03, Chun-Hung Wu wrote:
> > Hi Jonathan:
> > 
> >   Thanks for the prompt reply,
> > 
> > On Sat, 2019-05-18 at 11:35 +0100, Jonathan Cameron wrote:
> >> On Thu, 16 May 2019 16:10:46 +0800
> >> Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:
> >>
> >>>   Move suspend/resume to late_suspend and
> >>> early_resume to gurantee users can use auxadc
> >> guarantee
> >>
> > will fix it in next version.
> >>> driver at suspend/resume stage.
> >> No problem with the patch content, but we need a reason why they may
> >> want to do so?
> > Our thermal drivers uses auxadc at suspend/resume stage.
> > In order to avoid auxadc suspended prior to thermal driver,
> > we move auxadc to late_suspend and early_resume.
> > 
> 
> That sounds like a user of device_links [1] to me.
> 
> [1] https://www.kernel.org/doc/html/latest/driver-api/device_link.html
> 
> > Thanks,
> > Chun-Hung
> >>
> >> Thanks,
> >>
> >> Jonathan
> >>>
> >>> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> >>> ---
> >>>  drivers/iio/adc/mt6577_auxadc.c | 7 ++++---
> >>>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> >>> index e1bdcc0..58d7cb2 100644
> >>> --- a/drivers/iio/adc/mt6577_auxadc.c
> >>> +++ b/drivers/iio/adc/mt6577_auxadc.c
> >>> @@ -326,9 +326,10 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
> >>>  	return 0;
> >>>  }
> >>>  
> >>> -static SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
> >>> -			 mt6577_auxadc_suspend,
> >>> -			 mt6577_auxadc_resume);
> >>> +static const struct dev_pm_ops mt6577_auxadc_pm_ops = {
> >>> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(mt6577_auxadc_suspend,
> >>> +				     mt6577_auxadc_resume)
> >>> +};
> >>>  
> >>>  static const struct of_device_id mt6577_auxadc_of_match[] = {
> >>>  	{ .compatible = "mediatek,mt2701-auxadc", .data = &mt8173_compat},
> >>
> > 
> > 


