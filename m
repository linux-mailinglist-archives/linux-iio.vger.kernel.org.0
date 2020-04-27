Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998E61BA408
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 14:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgD0Mx5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 08:53:57 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15744 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727830AbgD0Mx5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 08:53:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587992036; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=oHj/1Cte/kqSnw6BUUytxEkRvBSBwIKK808zQI9LFHE=; b=WazAahDk8poUV/MQmRBuHzQS9ZXvZ8EGiPpCRJsLqIqdL28KtcfF2OSIy3deyRIx/q6oJFn5
 BThGBYfSaOauYa0Ys4ABSaLjhRDjQtL+bwpQnisWryGz4SOceqvdcq0UK4afitJgPtJRuJLt
 2Ob8h32pFOjD90HtoPkhzyF9Jas=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea6d5d3.7fb15c300340-smtp-out-n04;
 Mon, 27 Apr 2020 12:53:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 30ECAC44793; Mon, 27 Apr 2020 12:53:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [157.44.245.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7B24C433CB;
        Mon, 27 Apr 2020 12:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7B24C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V2 1/3] iio: adc: Convert the QCOM SPMI ADC bindings to
 .yaml format
To:     Rob Herring <robh@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <1586942266-21480-1-git-send-email-jprakash@codeaurora.org>
 <1586942266-21480-2-git-send-email-jprakash@codeaurora.org>
 <20200416204241.GA14143@bogus>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <b41fc1ea-1047-6305-bf58-fd8d4d72282d@codeaurora.org>
Date:   Mon, 27 Apr 2020 18:23:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416204241.GA14143@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob

I can see the first error:  "....chosen node must be at root node" from 
'make dt_binding_check' even without my patch applied, so it does not 
seem related. I will fix the second error in the next post.

On 4/17/2020 2:12 AM, Rob Herring wrote:
> On Wed, 15 Apr 2020 14:47:44 +0530, Jishnu Prakash wrote:
>> Convert the adc bindings from .txt to .yaml format.
>>
>> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
>> ---
>>   .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 173 -------------
>>   .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 288 +++++++++++++++++++++
>>   2 files changed, 288 insertions(+), 173 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dt.yaml: adc@3100: 'adc-chan@0x39', 'adc-chan@0x9', 'adc-chan@0xa', 'adc-chan@0xe', 'adc-chan@0xf' do not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
>
> See https://patchwork.ozlabs.org/patch/1271025
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
>
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
>
> Please check and re-submit.
