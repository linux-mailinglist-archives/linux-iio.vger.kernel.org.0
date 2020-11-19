Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80B72B9736
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 17:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgKSP6i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 10:58:38 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50157 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgKSP6i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Nov 2020 10:58:38 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2D10320013;
        Thu, 19 Nov 2020 15:58:32 +0000 (UTC)
Message-ID: <1552bf3b5f8b9bc65e1177a87f1cd5a53899eaec.camel@hadess.net>
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-iio@vger.kernel.org, Nitin Joshi1 <njoshi1@lenovo.com>,
        linux-input@vger.kernel.org
Date:   Thu, 19 Nov 2020 16:58:32 +0100
In-Reply-To: <19622786-6aa9-483a-bbad-28112ea3609a@redhat.com>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
         <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
         <20201007083602.00006b7e@Huawei.com>
         <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
         <20201112062348.GF1003057@dtor-ws>
         <96e2c4ebd7e826b6ea52f72f301fb5e8c33479d5.camel@hadess.net>
         <19622786-6aa9-483a-bbad-28112ea3609a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2020-11-19 at 16:24 +0100, Hans de Goede wrote:
> <snip>
> > I had nearly finished working on updated code and all the test
> > suite
> > changes needed to use an input device with switches when IIO
> > started
> > being discussed, so I stopped in my tracks.
> 
> Ouch, sorry about this.

It happens, and the biggest problem I had was generating mock events
through umockdev.

Looks like I might have to finally implement:
https://github.com/martinpitt/umockdev/issues/43
which has the benefit of also helping me with iio-sensor-proxy.

