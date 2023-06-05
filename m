Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2BE722AB5
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jun 2023 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjFEPRl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 5 Jun 2023 11:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjFEPRk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jun 2023 11:17:40 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89238C5;
        Mon,  5 Jun 2023 08:17:38 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-977fae250easo9371166b.1;
        Mon, 05 Jun 2023 08:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685978257; x=1688570257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbfcYeB2w7B50q0ysWHxmmSLJ1HrD1Fyk9f2XcX1nIM=;
        b=YIlScVvTydX5ArkYaSK1NS1gUYAnlM/j3L12Aoaeu+qOFcnUNdFNNKrncINuS//ULe
         geSI35ep17cwD6+uVsfAKgPKApy5kEQntGTP68h3IJeO+qB7nDVleKrB4IQLpsp+FqmJ
         N0F90Ambw9BjRyACw2QSl/YGpoHVb2pDAxReQp9NmUBCg18uG3O2RKhe7wwmTb1IygPi
         ewVH6jnJNlUgkYSTZLPHB7bJxxHP+uokKl3n/P2glbmQ5HnSNFHqeCnmdg1ZNZTjnOey
         jhTg0DokShSB/yodNat8JOZTMmuRxFgzpSwPfx2D19EbemniriSjOVA9tQFfX0XFYDGK
         QZ2A==
X-Gm-Message-State: AC+VfDztjc78RPmbXIX8RnkwGey35AE3lir9KgG0hhWvm0DsmttB5L/2
        xGTk21aGwpwinUNExNB8MknilOIddQAFuM7xlBk=
X-Google-Smtp-Source: ACHHUZ6uIrTpJo8B2/LjSDlhZ/ojQ4YYPlmrHQ5V4qFBg1Aj+EgMbPqMXHJF0QkTRIqCxxEEOydVwz23MR772NERjco=
X-Received: by 2002:a17:906:5188:b0:974:6025:cc6 with SMTP id
 y8-20020a170906518800b0097460250cc6mr7300451ejk.6.1685978256665; Mon, 05 Jun
 2023 08:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230601131719.300720-1-michal.wilczynski@intel.com>
 <4500594.LvFx2qVVIh@kreacher> <eb5ed997-201a-ffc4-6181-b2f8a6d451a8@intel.com>
In-Reply-To: <eb5ed997-201a-ffc4-6181-b2f8a6d451a8@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Jun 2023 17:17:17 +0200
Message-ID: <CAJZ5v0hWKUbX0vdp09uD2-QNH611S4gZEirnQtj78oXiQ2YJQA@mail.gmail.com>
Subject: Re: [PATCH v4 01/35] acpi: Adjust functions installing bus event handlers
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, jic23@kernel.org, lars@metafoo.de,
        bleung@chromium.org, yu.c.chen@intel.com, hdegoede@redhat.com,
        markgross@kernel.org, luzmaximilian@gmail.com,
        corentin.chary@gmail.com, jprvita@gmail.com,
        cascardo@holoscopio.com, don@syst.com.br, pali@kernel.org,
        jwoithe@just42.net, matan@svgalib.org, kenneth.t.chan@gmail.com,
        malattia@linux.it, jeremy@system76.com, productdev@system76.com,
        herton@canonical.com, coproscefalo@gmail.com, tytso@mit.edu,
        Jason@zx2c4.com, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        acpica-devel@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 5, 2023 at 10:44 AM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
> On 6/2/2023 8:34 PM, Rafael J. Wysocki wrote:
> > On Thursday, June 1, 2023 3:17:19 PM CEST Michal Wilczynski wrote:
> >> Currently acpi_device_install_notify_handler() and
> >> acpi_device_remove_notify_handler() always install acpi_notify_device()
> >> as a function handler, and only then the real .notify callback gets
> >> called. This is not efficient and doesn't provide any real advantage.
> >>
> >> Introduce new acpi_device_install_event_handler() and
> >> acpi_device_remove_event_handler(). Those functions are replacing old
> >> installers, and after all drivers switch to the new model, old installers
> >> will be removed at the end of the patchset.
> >>
> >> Make new installer/removal function arguments to take function pointer as
> >> an argument instead of using .notify callback. Introduce new variable in
> >> struct acpi_device, as fixed events still needs to be handled by an
> >> intermediary that would schedule them for later execution. This is due to
> >> fixed hardware event handlers being executed in interrupt context.
> >>
> >> Make acpi_device_install_event_handler() and
> >> acpi_device_remove_event_handler() non-static, and export symbols. This
> >> will allow the drivers to call them directly, instead of relying on
> >> .notify callback.
> >>
> >> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >> ---
> >>  drivers/acpi/bus.c      | 59 ++++++++++++++++++++++++++++++++++++++++-
> >>  include/acpi/acpi_bus.h |  7 +++++
> >>  2 files changed, 65 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> >> index d161ff707de4..cf2c2bfe29a0 100644
> >> --- a/drivers/acpi/bus.c
> >> +++ b/drivers/acpi/bus.c
> >> @@ -535,7 +535,7 @@ static void acpi_notify_device_fixed(void *data)
> >>      struct acpi_device *device = data;
> >>
> >>      /* Fixed hardware devices have no handles */
> >> -    acpi_notify_device(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
> >> +    device->fixed_event_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
> >>  }
> >>
> >>  static u32 acpi_device_fixed_event(void *data)
> >> @@ -550,11 +550,13 @@ static int acpi_device_install_notify_handler(struct acpi_device *device,
> >>      acpi_status status;
> >>
> >>      if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> >> +            device->fixed_event_notify = acpi_notify_device;
> >>              status =
> >>                  acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> >>                                                   acpi_device_fixed_event,
> >>                                                   device);
> >>      } else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
> >> +            device->fixed_event_notify = acpi_notify_device;
> >>              status =
> >>                  acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> >>                                                   acpi_device_fixed_event,
> >> @@ -579,9 +581,11 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
> >>      if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> >>              acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> >>                                              acpi_device_fixed_event);
> >> +            device->fixed_event_notify = NULL;
> >>      } else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
> >>              acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> >>                                              acpi_device_fixed_event);
> >> +            device->fixed_event_notify = NULL;
> >>      } else {
> >>              u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
> >>                              ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
> >> @@ -592,6 +596,59 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
> >>      acpi_os_wait_events_complete();
> >>  }
> >>
> >> +int acpi_device_install_event_handler(struct acpi_device *device,
> >> +                                  u32 type,
> >> +                                  void (*notify)(acpi_handle, u32, void*))
> >> +{
> >> +    acpi_status status;
> >> +
> >> +    if (!notify)
> >> +            return -EINVAL;
> >> +
> >> +    if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> >> +            device->fixed_event_notify = notify;
> >> +            status =
> >> +                acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> >> +                                                 acpi_device_fixed_event,
> >> +                                                 device);
> >> +    } else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
> >> +            device->fixed_event_notify = notify;
> >> +            status =
> >> +                acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> >> +                                                 acpi_device_fixed_event,
> >> +                                                 device);
> >> +    } else {
> >> +            status = acpi_install_notify_handler(device->handle, type,
> >> +                                                 notify,
> >> +                                                 device);
> >> +    }
> >> +
> >> +    if (ACPI_FAILURE(status))
> >> +            return -EINVAL;
> >> +    return 0;
> >> +}
> >> +EXPORT_SYMBOL(acpi_device_install_event_handler);
> >> +
> >> +void acpi_device_remove_event_handler(struct acpi_device *device,
> >> +                                  u32 type,
> >> +                                  void (*notify)(acpi_handle, u32, void*))
> >> +{
> >> +    if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> >> +            acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> >> +                                            acpi_device_fixed_event);
> >> +            device->fixed_event_notify = NULL;
> >> +    } else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
> >> +            acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> >> +                                            acpi_device_fixed_event);
> >> +            device->fixed_event_notify = NULL;
> >> +    } else {
> >> +            acpi_remove_notify_handler(device->handle, type,
> >> +                                       notify);
> >> +    }
> >> +    acpi_os_wait_events_complete();
> >> +}
> >> +EXPORT_SYMBOL(acpi_device_remove_event_handler);
> >> +
> >>  /* Handle events targeting \_SB device (at present only graceful shutdown) */
> >>
> >>  #define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
> >> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> >> index a6affc0550b0..7fb411438b6f 100644
> >> --- a/include/acpi/acpi_bus.h
> >> +++ b/include/acpi/acpi_bus.h
> >> @@ -387,6 +387,7 @@ struct acpi_device {
> >>      struct list_head physical_node_list;
> >>      struct mutex physical_node_lock;
> >>      void (*remove)(struct acpi_device *);
> >> +    void (*fixed_event_notify)(acpi_handle handle, u32 type, void *data);
>
>
> Hi,
> Thank for you review,
>
> > This is a rather confusing change, because ->remove() above is not a driver
> > callback, whereas the new one would be.
> >
> > Moreover, it is rather wasteful, because the only devices needing it are
> > buttons, so for all of the other ACPI device objects the new callback pointer
> > would always be NULL.
> >
> > Finally, it is not necessary even.
>
> I was thinking about resolving this somehow in compile-time, but I guess was a bit
> afraid of refactoring too much code - didn't want to break anything.
>
> >
> > The key observation here is that there are only 2 drivers handling power and
> > sleep buttons that use ACPI fixed events: the ACPI button driver (button.c in
> > drivers/acpi) and the "tiny power button" driver (tiny-power-button.c in
> > drivers/acpi).  All of the other drivers don't need the "fixed event notify"
> > thing and these two can be modified to take care of all of it by themselves.
> >
> > So if something like the below is done prior to the rest of your series, the
> > rest will be about acpi_install/remove_notify_handler() only and you won't
> > even need the wrapper routines any more: driver may just be switched over
> > to using the ACPICA functions directly.
>
> Sure, will get your patch, apply it before my series and fix individual drivers to use acpica
> functions directly.

I have posted this series which replaces it  in the meantime:
https://lore.kernel.org/linux-acpi/1847933.atdPhlSkOF@kreacher

Moreover, I think that there's still a reason to use the wrappers.

Namely, the unregistration part needs to call
acpi_os_wait_events_complete() after the notify handler has been
unregistered and it's better to avoid code duplication related to
that.

Also the registration wrapper can be something like:

int acpi_dev_install_notify_handler(struct acpi_device *adev,
acpi_notify_handler handler, u32 handler_type)
{
    if (ACPI_FAILURE(acpi_install_notify_handler(adev->handle,
handler_type, handler, adev)))
        return -ENODEV;

    return 0;
}

which would be simpler to use than the "raw"
acpi_install_notify_handler() and using it would avoid a tiny bit of
code duplication IMV.
