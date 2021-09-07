Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67FD40297D
	for <lists+linux-iio@lfdr.de>; Tue,  7 Sep 2021 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344624AbhIGNOy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Sep 2021 09:14:54 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:52000 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243976AbhIGNOy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Sep 2021 09:14:54 -0400
Received: from [192.168.224.11] (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id 4D2E544A024D;
        Tue,  7 Sep 2021 15:13:45 +0200 (CEST)
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: chemical: sensirion,scd4x: Add
 yaml description
To:     Rob Herring <robh@kernel.org>
Cc:     david@protonic.nl, Jonathan Cameron <jic23@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
References: <20210901105911.178646-1-roan@protonic.nl>
 <20210901105911.178646-2-roan@protonic.nl>
 <YTJ8z2RpR0JUo2Yk@robh.at.kernel.org>
From:   Roan van Dijk <roan@protonic.nl>
Message-ID: <420dc3e5-3bfb-b29f-25bb-bfdadfad9dc2@protonic.nl>
Date:   Tue, 7 Sep 2021 15:13:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTJ8z2RpR0JUo2Yk@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: nl
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 03-09-2021 21:51, Rob Herring wrote:
> On Wed, 01 Sep 2021 12:59:09 +0200, Roan van Dijk wrote:
>> Add documentation for the SCD4x carbon dioxide sensor from Sensirion.
>>
>> Signed-off-by: Roan van Dijk <roan@protonic.nl>
>> ---
>>   .../iio/chemical/sensirion,scd4x.yaml         | 46 +++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
>>
> Reviewed-by: Rob Herring <robh@kernel.org>
Sorry, I forgot about this. It will be added to the next patch.

Thanks,

Roan
