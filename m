Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520A11B96A3
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 07:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgD0Fjs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 01:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726172AbgD0Fjr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 01:39:47 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB50C061A0F;
        Sun, 26 Apr 2020 22:39:47 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id 190so3586600ooa.12;
        Sun, 26 Apr 2020 22:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Et1SvPKNxJYM7++FJdtng9sXsZ2bJ8ovNJzi+Ohdd2Q=;
        b=HxT+JU4Vp1hoyYZJ4f8+M9+4t6ERG9EZ6uHWb7YHaVpk9I883sDq9LwTMvyrxqzCEF
         RSBXeoER36Cj65euvE4xFTJCC6GPBKYq85/PxzosZHD4P96WTSuWJZBG+R95xdcdSYaX
         ZQk2/Sma4qqe489NiLYlCyIKsEKxyhxqwcMuDQeRNK2SEPMyz7tSvWFUGADxfxJ08uSs
         AdOLVmyv8YCcpdcQlSimDjzUHdxJyQMIUOwIMNR2OhZ8mqmiZ+ruhanBf4AdEKa+Pb8z
         2txLYj7D+BGdfgTYY3iRWlmrpWHWhauKYx0NkHwlzc5VMh6/oND+82hG58LC9IGpp27w
         7gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Et1SvPKNxJYM7++FJdtng9sXsZ2bJ8ovNJzi+Ohdd2Q=;
        b=s7+H/jiiG9/bopP6jsHATN0AhrvfGunKskhZNla9cQ0CP/0xNNa6DJQE+QyIwHmIYo
         cUlmhHVreyUYeKn4B2/3Qa11+YjI1U8l7RICV4sseVfA5f/qcz26j507pwKtacK3WzCh
         PS/SgQdMGUG/b8XaaMUXrpWeyEwkUhTMnGJ2O3jKRRt9XaNyQ2A8mGGqm+HX/Ynz93EA
         vlXMGPgyfixlUvmotdqBYpAnVBAmSUhnYzQUFBaxFqU0o1/aULO+Qd6fyBYRpumuZoUC
         0pB2Or807MX/GmIYevvMZ2DATFelMbMDVfckJ61cLRmSnaa3u4wtYiqhGXIIn0tJnYt+
         Bfww==
X-Gm-Message-State: AGi0PuYvD0I8jEaGCNUZEpUxqdl3HulNRmgnRNl+FPhvqDK+97YQ2iak
        hanpVq4/V+18Cm3xwt8qDbDZyI6mKKpl4ed2C9M=
X-Google-Smtp-Source: APiQypJyU5Q8KH1LDzUAJw9CVDNbDXyEU6xa0nP35pe4WkSoEcnw7yiw5eM+BNQv7qZKf11TciDMuXZdTZPXgEFHRxc=
X-Received: by 2002:a4a:7011:: with SMTP id r17mr17427507ooc.17.1587965986481;
 Sun, 26 Apr 2020 22:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200424043418.3579-1-alexandru.ardelean@analog.com>
 <9bdf62ca5de58c6fff452691fae51692198f3b75.camel@linux.intel.com>
 <5fef17cf2d9694ce897fe2bb1a4687dc48850f88.camel@analog.com>
 <a3ee7b48f903e5f221bf5ac21af9a7894fde53b2.camel@analog.com>
 <f19bc3826c0969693b7a203b271092b10989d9e6.camel@linux.intel.com> <CA+U=DspYTQw7anRAv-Mn5pVhRrtAS-uAVOCuXennpg_Jg=YU3g@mail.gmail.com>
In-Reply-To: <CA+U=DspYTQw7anRAv-Mn5pVhRrtAS-uAVOCuXennpg_Jg=YU3g@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 27 Apr 2020 08:39:33 +0300
Message-ID: <CA+U=Dsr63_NZyYEtbwHkuZWQY-+7qoiSH8Z99+1TJFOyv=Xajg@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensors: move triggered buffer setup into hid_sensor_setup_trigger
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 27, 2020 at 8:38 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Sun, Apr 26, 2020 at 10:22 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > On Sat, 2020-04-25 at 07:22 +0000, Ardelean, Alexandru wrote:
> > > On Sat, 2020-04-25 at 06:28 +0000, Ardelean, Alexandru wrote:
> > > > [External]
> > > >
> > > > On Fri, 2020-04-24 at 14:31 -0700, Srinivas Pandruvada wrote:
> > > > > [External]
> > > > >
> > > > > On Fri, 2020-04-24 at 07:34 +0300, Alexandru Ardelean wrote:
> > > > > > The main intent here is to get rid of the
> > > > > > iio_buffer_set_attrs()
> > > > > > helper, or
> > > > > > at least rework it's usage a bit.
> > > > > > The problem with that helper is that it needs a pointer to the
> > > > > > buffer,
> > > > > > which makes supporting multiple buffers per IIO device a bit
> > > > > > more
> > > > > > cumbersome.
> > > > > >
> > > > > > The hid_sensor_setup_trigger() is pretty much used in the same
> > > > > > way:
> > > > > > - iio_triggered_buffer_setup() gets called before
> > > > > > - then hid_sensor_setup_trigger() and
> > > > > > hid_sensor_setup_batch_mode()
> > > > > > gets
> > > > > >   called which may attach some fifo attributes
> > > > > >
> > > > > > This change merges the 2 together under the
> > > > > > hid_sensor_setup_trigger()
> > > > > > function. Only the &iio_pollfunc_store_time is passed to all
> > > > > > devices,
> > > > > > so
> > > > > > it's not even required to pass it explicitly outside of the
> > > > > > common
> > > > > > hid_sensor_setup_trigger() function.
> > > > > >
> > > > > > Moving the devm_iio_triggered_buffer_setup/cleanup() calls into
> > > > > > the
> > > > > > common
> > > > > > place code can help the rework of the buffer code, since it is
> > > > > > in one
> > > > > > place.
> > > > > >
> > > > > > One detail of the change is that there are 2 drivers that use
> > > > > > devm_iio_triggered_buffer_setup(). That function gets
> > > > > > implicitly
> > > > > > replaced with iio_triggered_buffer_setup()/cleanup(), but since
> > > > > > all
> > > > > > drivers
> > > > > > call both hid_sensor_setup_trigger9) &
> > > > > > hid_sensor_remove_trigger()
> > > > > > trigger,
> > > > > > the iio_triggered_buffer_cleanup() piggy backs on the
> > > > > > hid_sensor_remove_trigger() call, which should cover the
> > > > > > cleanup.
> > > > >
> > > > > Did you test on any platform? You can check any later laptops and
> > > > > check
> > > > > display rotation.
> > > >
> > > > Sorry, I didn't.
> > > > I do remember seeing this on some smaller tablet-laptops, but I
> > > > don't have one
> > > > around.
> > > > The newest I have is Dell Precision 5520 from 2 years ago. Which is
> > > > more of an
> > > > office laptop.
> > > >
> > > > I can't seem to find any IIO devices on it.
> > > > So, I don't think it has any display rotation; on Windows I'm
> > > > pretty sure I
> > > > didn't see anything about.
> > > >
> > >
> > > I should mention.
> > > I'm running XUbuntu 19.10, kernel version is 5.3
> > > XUbuntu is basically Ubuntu re-packaged with XFCE.
> >
> > Not sure about this laptop. But most of the 2-in-1s released in last 2-
> > 3 years should have sensor hub in it.
> > Can you check lspci -vvv?
> >
>

It does have a touchscreen, though that seems to be dangling off USB.
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 04f3:24a0 Elan Microelectronics Corp. Touchscreen
Bus 001 Device 002: ID 8087:0a2b Intel Corp.
Bus 001 Device 004: ID 0c45:6713 Microdia Integrated_Webcam_HD
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub


> Sure.
>
> 00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core
> Processor Host Bridge/DRAM Registers (rev 05)
>     Subsystem: Dell Xeon E3-1200 v6/7th Gen Core Processor Host
> Bridge/DRAM Registers
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Capabilities: [e0] Vendor Specific Information: Len=10 <?>
>     Kernel driver in use: skl_uncore
>
> 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th
> Gen Core Processor PCIe Controller (x16) (rev 05) (prog-if 00 [Normal
> decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 122
>     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>     I/O behind bridge: 0000e000-0000efff [size=4K]
>     Memory behind bridge: ec000000-ed0fffff [size=17M]
>     Prefetchable memory behind bridge:
> 00000000c0000000-00000000d1ffffff [size=288M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [88] Subsystem: Dell Xeon E3-1200 v5/E3-1500 v5/6th
> Gen Core Processor PCIe Controller (x16)
>     Capabilities: [80] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee00218  Data: 0000
>     Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 256 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
>         LnkCap:    Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <8us
>             ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 8GT/s (ok), Width x16 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt+
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>             Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>             Changed: MRL- PresDet+ LinkState-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+,
> OBFF Via WAKE# ARIFwd-
>              AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Via WAKE# ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete+, EqualizationPhase1+
>              EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>             Status:    NegoPending- InProgress-
>     Capabilities: [140 v1] Root Complex Link
>         Desc:    PortNumber=02 ComponentID=01 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=01 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed19000
>     Capabilities: [d94 v1] Secondary PCI Express <?>
>     Kernel driver in use: pcieport
>
> 00:02.0 VGA compatible controller: Intel Corporation HD Graphics 630
> (rev 04) (prog-if 00 [VGA controller])
>     DeviceName:  Onboard IGD
>     Subsystem: Dell HD Graphics 630
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 142
>     Region 0: Memory at eb000000 (64-bit, non-prefetchable) [size=16M]
>     Region 2: Memory at 80000000 (64-bit, prefetchable) [size=256M]
>     Region 4: I/O ports at f000 [size=64]
>     [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
>     Capabilities: [40] Vendor Specific Information: Len=0c <?>
>     Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
> OBFF Not Supported
>              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
> OBFF Disabled
>              AtomicOpsCtl: ReqEn-
>     Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee00018  Data: 0000
>     Capabilities: [d0] Power Management version 2
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Process Address Space ID (PASID)
>         PASIDCap: Exec- Priv-, Max PASID Width: 14
>         PASIDCtl: Enable- Exec- Priv-
>     Capabilities: [200 v1] Address Translation Service (ATS)
>         ATSCap:    Invalidate Queue Depth: 00
>         ATSCtl:    Enable-, Smallest Translation Unit: 00
>     Capabilities: [300 v1] Page Request Interface (PRI)
>         PRICtl: Enable- Reset-
>         PRISta: RF- UPRGI- Stopped+
>         Page Request Capacity: 00008000, Page Request Allocation: 00000000
>     Kernel driver in use: i915
>     Kernel modules: i915
>
> 00:04.0 Signal processing controller: Intel Corporation Xeon E3-1200
> v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem (rev 05)
>     Subsystem: Dell Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor
> Thermal Subsystem
>     Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin A routed to IRQ 16
>     Region 0: Memory at edd20000 (64-bit, non-prefetchable) [size=32K]
>     Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [d0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>     Kernel driver in use: proc_thermal
>     Kernel modules: processor_thermal_device
>
> 00:14.0 USB controller: Intel Corporation 100 Series/C230 Series
> Chipset Family USB 3.0 xHCI Controller (rev 31) (prog-if 30 [XHCI])
>     Subsystem: Dell 100 Series/C230 Series Chipset Family USB 3.0 xHCI
> Controller
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 128
>     Region 0: Memory at edd10000 (64-bit, non-prefetchable) [size=64K]
>     Capabilities: [70] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
>         Address: 00000000fee00338  Data: 0000
>     Kernel driver in use: xhci_hcd
>
> 00:14.2 Signal processing controller: Intel Corporation 100
> Series/C230 Series Chipset Family Thermal Subsystem (rev 31)
>     Subsystem: Dell 100 Series/C230 Series Chipset Family Thermal Subsystem
>     Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin C routed to IRQ 18
>     Region 0: Memory at edd39000 (64-bit, non-prefetchable) [size=4K]
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Kernel driver in use: intel_pch_thermal
>     Kernel modules: intel_pch_thermal
>
> 00:15.0 Signal processing controller: Intel Corporation 100
> Series/C230 Series Chipset Family Serial IO I2C Controller #0 (rev 31)
>     Subsystem: Dell 100 Series/C230 Series Chipset Family Serial IO
> I2C Controller
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin A routed to IRQ 16
>     Region 0: Memory at edd38000 (64-bit, non-prefetchable) [size=4K]
>     Capabilities: [80] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [90] Vendor Specific Information: Len=14 <?>
>     Kernel driver in use: intel-lpss
>     Kernel modules: intel_lpss_pci
>
> 00:15.1 Signal processing controller: Intel Corporation 100
> Series/C230 Series Chipset Family Serial IO I2C Controller #1 (rev 31)
>     Subsystem: Dell 100 Series/C230 Series Chipset Family Serial IO
> I2C Controller
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin B routed to IRQ 17
>     Region 0: Memory at edd37000 (64-bit, non-prefetchable) [size=4K]
>     Capabilities: [80] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [90] Vendor Specific Information: Len=14 <?>
>     Kernel driver in use: intel-lpss
>     Kernel modules: intel_lpss_pci
>
> 00:16.0 Communication controller: Intel Corporation 100 Series/C230
> Series Chipset Family MEI Controller #1 (rev 31)
>     Subsystem: Dell 100 Series/C230 Series Chipset Family MEI Controller
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 140
>     Region 0: Memory at edd36000 (64-bit, non-prefetchable) [size=4K]
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee004d8  Data: 0000
>     Kernel driver in use: mei_me
>     Kernel modules: mei_me
>
> 00:16.3 Serial controller: Intel Corporation 100 Series/C230 Series
> Chipset Family KT Redirection (rev 31) (prog-if 02 [16550])
>     Subsystem: Dell 100 Series/C230 Series Chipset Family KT Redirection
>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin D routed to IRQ 19
>     Region 0: I/O ports at f0a0 [size=8]
>     Region 1: Memory at edd35000 (32-bit, non-prefetchable) [size=4K]
>     Capabilities: [40] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Kernel driver in use: serial
>
> 00:17.0 SATA controller: Intel Corporation
> Q170/Q150/B150/H170/H110/Z170/CM236 Chipset SATA Controller [AHCI
> Mode] (rev 31) (prog-if 01 [AHCI 1.0])
>     Subsystem: Dell Q170/Q150/B150/H170/H110/Z170/CM236 Chipset SATA
> Controller [AHCI Mode]
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 130
>     Region 0: Memory at edd30000 (32-bit, non-prefetchable) [size=8K]
>     Region 1: Memory at edd34000 (32-bit, non-prefetchable) [size=256]
>     Region 2: I/O ports at f090 [size=8]
>     Region 3: I/O ports at f080 [size=4]
>     Region 4: I/O ports at f060 [size=32]
>     Region 5: Memory at edd33000 (32-bit, non-prefetchable) [size=2K]
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee00378  Data: 0000
>     Capabilities: [70] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
>     Kernel driver in use: ahci
>     Kernel modules: ahci
>
> 00:1c.0 PCI bridge: Intel Corporation 100 Series/C230 Series Chipset
> Family PCI Express Root Port #1 (rev f1) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 123
>     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>     I/O behind bridge: 0000f000-00000fff [empty]
>     Memory behind bridge: edc00000-edcfffff [size=1M]
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [empty]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>         LnkCap:    Port #1, Speed 8GT/s, Width x1, ASPM L1, Exit
> Latency L1 <16us
>             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (downgraded), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>             Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>             Changed: MRL- PresDet- LinkState+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
> OBFF Not Supported ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee00238  Data: 0000
>     Capabilities: [90] Subsystem: Dell 100 Series/C230 Series Chipset
> Family PCI Express Root Port
>     Capabilities: [a0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>         RootCmd: CERptEn+ NFERptEn+ FERptEn+
>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>     Capabilities: [140 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
> UpstreamFwd- EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir-
> UpstreamFwd- EgressCtrl- DirectTrans-
>     Capabilities: [220 v1] Secondary PCI Express <?>
>     Kernel driver in use: pcieport
>
> 00:1c.1 PCI bridge: Intel Corporation 100 Series/C230 Series Chipset
> Family PCI Express Root Port #2 (rev f1) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 124
>     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>     I/O behind bridge: 0000d000-0000dfff [size=4K]
>     Memory behind bridge: ed100000-edafffff [size=10M]
>     Prefetchable memory behind bridge:
> 00000000d2100000-00000000d2afffff [size=10M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 256 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>         LnkCap:    Port #2, Speed 8GT/s, Width x1, ASPM L1, Exit
> Latency L1 <16us
>             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 5GT/s (downgraded), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>             Slot #5, PowerLimit 10.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
> HPIrq- LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>             Changed: MRL- PresDet- LinkState-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
> OBFF Not Supported ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee00278  Data: 0000
>     Capabilities: [90] Subsystem: Dell 100 Series/C230 Series Chipset
> Family PCI Express Root Port
>     Capabilities: [a0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt+
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>         RootCmd: CERptEn+ NFERptEn+ FERptEn+
>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>     Capabilities: [140 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
> UpstreamFwd- EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir-
> UpstreamFwd- EgressCtrl- DirectTrans-
>     Capabilities: [220 v1] Secondary PCI Express <?>
>     Kernel driver in use: pcieport
>
> 00:1d.0 PCI bridge: Intel Corporation 100 Series/C230 Series Chipset
> Family PCI Express Root Port #9 (rev f1) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 125
>     Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>     I/O behind bridge: 0000f000-00000fff [empty]
>     Memory behind bridge: edb00000-edbfffff [size=1M]
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [empty]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 256 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>         LnkCap:    Port #9, Speed 8GT/s, Width x4, ASPM L1, Exit
> Latency L1 <16us
>             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 8GT/s (ok), Width x4 (ok)
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>             Slot #12, PowerLimit 25.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>             Changed: MRL- PresDet- LinkState+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
> OBFF Not Supported ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete+, EqualizationPhase1+
>              EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee00298  Data: 0000
>     Capabilities: [90] Subsystem: Dell 100 Series/C230 Series Chipset
> Family PCI Express Root Port
>     Capabilities: [a0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>         RootCmd: CERptEn+ NFERptEn+ FERptEn+
>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>     Capabilities: [140 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
> UpstreamFwd- EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir-
> UpstreamFwd- EgressCtrl- DirectTrans-
>     Capabilities: [220 v1] Secondary PCI Express <?>
>     Kernel driver in use: pcieport
>
> 00:1d.4 PCI bridge: Intel Corporation 100 Series/C230 Series Chipset
> Family PCI Express Root Port #13 (rev f1) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 126
>     Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
>     I/O behind bridge: 0000f000-00000fff [empty]
>     Memory behind bridge: fff00000-000fffff [empty]
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [empty]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>         LnkCap:    Port #13, Speed 8GT/s, Width x2, ASPM L0s L1, Exit
> Latency L0s unlimited, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (downgraded), Width x0 (downgraded)
>             TrErr- Train+ SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
> OBFF Via WAKE# ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee002b8  Data: 0000
>     Capabilities: [90] Subsystem: Dell 100 Series/C230 Series Chipset
> Family PCI Express Root Port
>     Capabilities: [a0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>     Kernel driver in use: pcieport
>
> 00:1d.6 PCI bridge: Intel Corporation 100 Series/C230 Series Chipset
> Family PCI Express Root Port #15 (rev f1) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin C routed to IRQ 127
>     Bus: primary=00, secondary=06, subordinate=3e, sec-latency=0
>     I/O behind bridge: 00002000-00002fff [size=4K]
>     Memory behind bridge: d4000000-ea0fffff [size=353M]
>     Prefetchable memory behind bridge:
> 0000000090000000-00000000b1ffffff [size=544M]
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>         LnkCap:    Port #15, Speed 8GT/s, Width x2, ASPM not supported
>             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (downgraded), Width x0 (downgraded)
>             TrErr- Train+ SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>             Slot #18, PowerLimit 25.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
> HPIrq- LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>             Changed: MRL- PresDet- LinkState-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
> OBFF Not Supported ARIFwd+
>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled ARIFwd-
>              AtomicOpsCtl: ReqEn- EgressBlck-
>         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee002f8  Data: 0000
>     Capabilities: [90] Subsystem: Dell 100 Series/C230 Series Chipset
> Family PCI Express Root Port
>     Capabilities: [a0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt+
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>         RootCmd: CERptEn+ NFERptEn+ FERptEn+
>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>     Capabilities: [140 v1] Access Control Services
>         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
> UpstreamFwd- EgressCtrl- DirectTrans-
>         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir-
> UpstreamFwd- EgressCtrl- DirectTrans-
>     Capabilities: [220 v1] Secondary PCI Express <?>
>     Kernel driver in use: pcieport
>
> 00:1f.0 ISA bridge: Intel Corporation CM238 Chipset LPC/eSPI Controller (rev 31)
>     Subsystem: Dell CM238 Chipset LPC/eSPI Controller
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>
> 00:1f.2 Memory controller: Intel Corporation 100 Series/C230 Series
> Chipset Family Power Management Controller (rev 31)
>     Subsystem: Dell 100 Series/C230 Series Chipset Family Power
> Management Controller
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Region 0: Memory at edd2c000 (32-bit, non-prefetchable) [disabled]
> [size=16K]
>
> 00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev
> 31) (prog-if 80)
>     Subsystem: Dell CM238 HD Audio Controller
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 32
>     Interrupt: pin B routed to IRQ 143
>     Region 0: Memory at edd28000 (64-bit, non-prefetchable) [size=16K]
>     Region 4: Memory at edd00000 (64-bit, non-prefetchable) [size=64K]
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee00518  Data: 0000
>     Kernel driver in use: snd_hda_intel
>     Kernel modules: snd_hda_intel
>
> 00:1f.4 SMBus: Intel Corporation 100 Series/C230 Series Chipset Family
> SMBus (rev 31)
>     Subsystem: Dell 100 Series/C230 Series Chipset Family SMBus
>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin A routed to IRQ 16
>     Region 0: Memory at edd32000 (64-bit, non-prefetchable) [size=256]
>     Region 4: I/O ports at f040 [size=32]
>     Kernel driver in use: i801_smbus
>     Kernel modules: i2c_i801
>
> 01:00.0 3D controller: NVIDIA Corporation GM107GLM [Quadro M1200
> Mobile] (rev a2)
>     Subsystem: Dell GM107GLM [Quadro M1200 Mobile]
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 255
>     Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
>     Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
>     Region 3: Memory at d0000000 (64-bit, prefetchable) [size=32M]
>     Region 5: I/O ports at e000 [disabled] [size=128]
>     Expansion ROM at ed000000 [disabled] [size=512K]
>     Capabilities: [60] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [78] Express (v2) Endpoint, MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 <64us
>             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> SlotPowerLimit 75.000W
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 256 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
>         LnkCap:    Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <1us, L1 <4us
>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 8GT/s (ok), Width x16 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR+, OBFF
> Via message
>              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled
>              AtomicOpsCtl: ReqEn-
>         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete+, EqualizationPhase1+
>              EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>             Status:    NegoPending- InProgress-
>     Capabilities: [250 v1] Latency Tolerance Reporting
>         Max snoop latency: 71680ns
>         Max no snoop latency: 71680ns
>     Capabilities: [258 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>               PortCommonModeRestoreTime=255us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=10us
>     Capabilities: [128 v1] Power Budgeting <?>
>     Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1
> Len=024 <?>
>     Capabilities: [900 v1] Secondary PCI Express <?>
>     Kernel modules: nvidiafb, nouveau, nvidia_drm, nvidia
>
> 02:00.0 Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
>     Subsystem: Intel Corporation Wireless 8265 / 8275
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 141
>     Region 0: Memory at edc00000 (64-bit, non-prefetchable) [size=8K]
>     Capabilities: [c8] Power Management version 3
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee004f8  Data: 0000
>     Capabilities: [40] Express (v2) Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 unlimited
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> SlotPowerLimit 0.000W
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit
> Latency L1 <8us
>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAKE#
>              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+,
> OBFF Disabled
>              AtomicOpsCtl: ReqEn-
>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Capabilities: [140 v1] Device Serial Number d4-25-8b-ff-ff-ea-6a-b9
>     Capabilities: [14c v1] Latency Tolerance Reporting
>         Max snoop latency: 3145728ns
>         Max no snoop latency: 3145728ns
>     Capabilities: [154 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>               PortCommonModeRestoreTime=30us PortTPowerOnTime=18us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=60us
>     Kernel driver in use: iwlwifi
>     Kernel modules: iwlwifi
>
> 03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
> RTS525A PCI Express Card Reader (rev 01)
>     Subsystem: Dell RTS525A PCI Express Card Reader
>     Physical Slot: 1
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 129
>     Region 1: Memory at ed100000 (32-bit, non-prefetchable) [size=4K]
>     Capabilities: [80] Power Management version 3
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee00358  Data: 0000
>     Capabilities: [b0] Express (v2) Endpoint, MSI 00
>         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> SlotPowerLimit 10.000W
>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 256 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
>         LnkCap:    Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s unlimited, L1 <64us
>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 5GT/s (ok), Width x1 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+,
> OBFF Via message/WAKE#
>              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled
>              AtomicOpsCtl: ReqEn-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [100 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
> ECRCChkCap+ ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Capabilities: [148 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
>     Capabilities: [158 v1] Latency Tolerance Reporting
>         Max snoop latency: 3145728ns
>         Max no snoop latency: 3145728ns
>     Capabilities: [160 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>               PortCommonModeRestoreTime=60us PortTPowerOnTime=60us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=60us
>     Kernel driver in use: rtsx_pci
>     Kernel modules: rtsx_pci
>
> 04:00.0 Non-Volatile memory controller: Toshiba America Info Systems
> Device 0116 (prog-if 02 [NVM Express])
>     Subsystem: Toshiba America Info Systems Device 0001
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 16
>     NUMA node: 0
>     Region 0: Memory at edb00000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [40] Express (v2) Endpoint, MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> SlotPowerLimit 25.000W
>         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
>             MaxPayload 256 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
>         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit
> Latency L1 <32us
>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 8GT/s (ok), Width x4 (ok)
>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR+, OBFF
> Not Supported
>              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled
>              AtomicOpsCtl: ReqEn-
>         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete+, EqualizationPhase1+
>              EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
>     Capabilities: [80] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [90] MSI: Enable- Count=1/32 Maskable+ 64bit+
>         Address: 0000000000000000  Data: 0000
>         Masking: 00000000  Pending: 00000000
>     Capabilities: [b0] MSI-X: Enable+ Count=32 Masked-
>         Vector table: BAR=0 offset=00002000
>         PBA: BAR=0 offset=00003000
>     Capabilities: [100 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>         HeaderLog: 00000000 00000000 00000000 00000000
>     Capabilities: [260 v1] Latency Tolerance Reporting
>         Max snoop latency: 3145728ns
>         Max no snoop latency: 3145728ns
>     Capabilities: [300 v1] Secondary PCI Express <?>
>     Capabilities: [400 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> L1_PM_Substates+
>               PortCommonModeRestoreTime=60us PortTPowerOnTime=100us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=100us
>     Kernel driver in use: nvme
>     Kernel modules: nvme
>
>
>
> >
> > Thanks,
> > Srinivas
> >
> > >
> > >
> > > > Maybe I missed it.
> > > > Any pointers are appreciated.
> > > >
> > > > Thanks
> > > > Alex
> > > >
> > > > > Thanks,
> > > > > Srinivas
> > > > >
> > > > > > Signed-off-by: Alexandru Ardelean <
> > > > > > alexandru.ardelean@analog.com>
> > > > > > ---
> > > > > >  drivers/iio/accel/hid-sensor-accel-3d.c        | 18 ++++----
> > > > > > ------
> > > > > > ----
> > > > > >  .../common/hid-sensors/hid-sensor-trigger.c    | 18
> > > > > > +++++++++++++++-
> > > > > > --
> > > > > >  .../common/hid-sensors/hid-sensor-trigger.h    |  3 ++-
> > > > > >  drivers/iio/gyro/hid-sensor-gyro-3d.c          | 18 ++++----
> > > > > > ------
> > > > > > ----
> > > > > >  drivers/iio/humidity/hid-sensor-humidity.c     | 12 +++-------
> > > > > > --
> > > > > >  drivers/iio/light/hid-sensor-als.c             | 18 ++++----
> > > > > > ------
> > > > > > ----
> > > > > >  drivers/iio/light/hid-sensor-prox.c            | 18 ++++----
> > > > > > ------
> > > > > > ----
> > > > > >  drivers/iio/magnetometer/hid-sensor-magn-3d.c  | 18 ++++----
> > > > > > ------
> > > > > > ----
> > > > > >  drivers/iio/orientation/hid-sensor-incl-3d.c   | 18 ++++----
> > > > > > ------
> > > > > > ----
> > > > > >  drivers/iio/orientation/hid-sensor-rotation.c  | 18 ++++----
> > > > > > ------
> > > > > > ----
> > > > > >  drivers/iio/pressure/hid-sensor-press.c        | 18 ++++----
> > > > > > ------
> > > > > > ----
> > > > > >  .../iio/temperature/hid-sensor-temperature.c   | 12 +++-------
> > > > > > --
> > > > > >  12 files changed, 55 insertions(+), 134 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c
> > > > > > b/drivers/iio/accel/hid-sensor-accel-3d.c
> > > > > > index 0d9e2def2b25..0ec0533448bc 100644
> > > > > > --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> > > > > > +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> > > > > > @@ -14,8 +14,6 @@
> > > > > >  #include <linux/iio/iio.h>
> > > > > >  #include <linux/iio/sysfs.h>
> > > > > >  #include <linux/iio/buffer.h>
> > > > > > -#include <linux/iio/trigger_consumer.h>
> > > > > > -#include <linux/iio/triggered_buffer.h>
> > > > > >  #include "../common/hid-sensors/hid-sensor-trigger.h"
> > > > > >
> > > > > >  enum accel_3d_channel {
> > > > > > @@ -391,18 +389,13 @@ static int hid_accel_3d_probe(struct
> > > > > > platform_device *pdev)
> > > > > >         indio_dev->name = name;
> > > > > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > >
> > > > > > -       ret = iio_triggered_buffer_setup(indio_dev,
> > > > > > &iio_pollfunc_store_time,
> > > > > > -               NULL, NULL);
> > > > > > -       if (ret) {
> > > > > > -               dev_err(&pdev->dev, "failed to initialize
> > > > > > trigger
> > > > > > buffer\n");
> > > > > > -               goto error_free_dev_mem;
> > > > > > -       }
> > > > > >         atomic_set(&accel_state->common_attributes.data_ready,
> > > > > > 0);
> > > > > > +
> > > > > >         ret = hid_sensor_setup_trigger(indio_dev, name,
> > > > > >                                         &accel_state-
> > > > > > > common_attributes);
> > > > > >         if (ret < 0) {
> > > > > >                 dev_err(&pdev->dev, "trigger setup failed\n");
> > > > > > -               goto error_unreg_buffer_funcs;
> > > > > > +               goto error_free_dev_mem;
> > > > > >         }
> > > > > >
> > > > > >         ret = iio_device_register(indio_dev);
> > > > > > @@ -426,9 +419,7 @@ static int hid_accel_3d_probe(struct
> > > > > > platform_device *pdev)
> > > > > >  error_iio_unreg:
> > > > > >         iio_device_unregister(indio_dev);
> > > > > >  error_remove_trigger:
> > > > > > -       hid_sensor_remove_trigger(&accel_state-
> > > > > > >common_attributes);
> > > > > > -error_unreg_buffer_funcs:
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &accel_state-
> > > > > > > common_attributes);
> > > > > >  error_free_dev_mem:
> > > > > >         kfree(indio_dev->channels);
> > > > > >         return ret;
> > > > > > @@ -443,8 +434,7 @@ static int hid_accel_3d_remove(struct
> > > > > > platform_device *pdev)
> > > > > >
> > > > > >         sensor_hub_remove_callback(hsdev, hsdev->usage);
> > > > > >         iio_device_unregister(indio_dev);
> > > > > > -       hid_sensor_remove_trigger(&accel_state-
> > > > > > >common_attributes);
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &accel_state-
> > > > > > > common_attributes);
> > > > > >         kfree(indio_dev->channels);
> > > > > >
> > > > > >         return 0;
> > > > > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-
> > > > > > trigger.c
> > > > > > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > > > index 906d87780419..ff375790b7e8 100644
> > > > > > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > > > @@ -13,6 +13,8 @@
> > > > > >  #include <linux/hid-sensor-hub.h>
> > > > > >  #include <linux/iio/iio.h>
> > > > > >  #include <linux/iio/trigger.h>
> > > > > > +#include <linux/iio/triggered_buffer.h>
> > > > > > +#include <linux/iio/trigger_consumer.h>
> > > > > >  #include <linux/iio/buffer.h>
> > > > > >  #include <linux/iio/sysfs.h>
> > > > > >  #include "hid-sensor-trigger.h"
> > > > > > @@ -222,7 +224,8 @@ static int
> > > > > > hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
> > > > > >         return
> > > > > > hid_sensor_power_state(iio_trigger_get_drvdata(trig),
> > > > > > state);
> > > > > >  }
> > > > > >
> > > > > > -void hid_sensor_remove_trigger(struct hid_sensor_common
> > > > > > *attrb)
> > > > > > +void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
> > > > > > +                              struct hid_sensor_common *attrb)
> > > > > >  {
> > > > > >         if (atomic_read(&attrb->runtime_pm_enable))
> > > > > >                 pm_runtime_disable(&attrb->pdev->dev);
> > > > > > @@ -233,6 +236,7 @@ void hid_sensor_remove_trigger(struct
> > > > > > hid_sensor_common *attrb)
> > > > > >         cancel_work_sync(&attrb->work);
> > > > > >         iio_trigger_unregister(attrb->trigger);
> > > > > >         iio_trigger_free(attrb->trigger);
> > > > > > +       iio_triggered_buffer_cleanup(indio_dev);
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(hid_sensor_remove_trigger);
> > > > > >
> > > > > > @@ -246,11 +250,18 @@ int hid_sensor_setup_trigger(struct
> > > > > > iio_dev
> > > > > > *indio_dev, const char *name,
> > > > > >         int ret;
> > > > > >         struct iio_trigger *trig;
> > > > > >
> > > > > > +       ret = iio_triggered_buffer_setup(indio_dev,
> > > > > > &iio_pollfunc_store_time,
> > > > > > +                                        NULL, NULL);
> > > > > > +       if (ret) {
> > > > > > +               dev_err(&indio_dev->dev, "Triggered Buffer
> > > > > > Setup
> > > > > > Failed\n");
> > > > > > +               return ret;
> > > > > > +       }
> > > > > > +
> > > > > >         trig = iio_trigger_alloc("%s-dev%d", name, indio_dev-
> > > > > > >id);
> > > > > >         if (trig == NULL) {
> > > > > >                 dev_err(&indio_dev->dev, "Trigger Allocate
> > > > > > Failed\n");
> > > > > >                 ret = -ENOMEM;
> > > > > > -               goto error_ret;
> > > > > > +               goto error_triggered_buffer_cleanup;
> > > > > >         }
> > > > > >
> > > > > >         trig->dev.parent = indio_dev->dev.parent;
> > > > > > @@ -284,7 +295,8 @@ int hid_sensor_setup_trigger(struct iio_dev
> > > > > > *indio_dev, const char *name,
> > > > > >         iio_trigger_unregister(trig);
> > > > > >  error_free_trig:
> > > > > >         iio_trigger_free(trig);
> > > > > > -error_ret:
> > > > > > +error_triggered_buffer_cleanup:
> > > > > > +       iio_triggered_buffer_cleanup(indio_dev);
> > > > > >         return ret;
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(hid_sensor_setup_trigger);
> > > > > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-
> > > > > > trigger.h
> > > > > > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> > > > > > index f47b940ff170..bb45cc89e551 100644
> > > > > > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> > > > > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> > > > > > @@ -13,7 +13,8 @@ extern const struct dev_pm_ops
> > > > > > hid_sensor_pm_ops;
> > > > > >
> > > > > >  int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const
> > > > > > char
> > > > > > *name,
> > > > > >                                 struct hid_sensor_common
> > > > > > *attrb);
> > > > > > -void hid_sensor_remove_trigger(struct hid_sensor_common
> > > > > > *attrb);
> > > > > > +void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
> > > > > > +                              struct hid_sensor_common
> > > > > > *attrb);
> > > > > >  int hid_sensor_power_state(struct hid_sensor_common *st, bool
> > > > > > state);
> > > > > >
> > > > > >  #endif
> > > > > > diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > > > b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > > > index 08cacbbf31e6..7f382aae1dfd 100644
> > > > > > --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > > > +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > > > @@ -14,8 +14,6 @@
> > > > > >  #include <linux/iio/iio.h>
> > > > > >  #include <linux/iio/sysfs.h>
> > > > > >  #include <linux/iio/buffer.h>
> > > > > > -#include <linux/iio/trigger_consumer.h>
> > > > > > -#include <linux/iio/triggered_buffer.h>
> > > > > >  #include "../common/hid-sensors/hid-sensor-trigger.h"
> > > > > >
> > > > > >  enum gyro_3d_channel {
> > > > > > @@ -326,18 +324,13 @@ static int hid_gyro_3d_probe(struct
> > > > > > platform_device *pdev)
> > > > > >         indio_dev->name = name;
> > > > > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > >
> > > > > > -       ret = iio_triggered_buffer_setup(indio_dev,
> > > > > > &iio_pollfunc_store_time,
> > > > > > -               NULL, NULL);
> > > > > > -       if (ret) {
> > > > > > -               dev_err(&pdev->dev, "failed to initialize
> > > > > > trigger
> > > > > > buffer\n");
> > > > > > -               goto error_free_dev_mem;
> > > > > > -       }
> > > > > >         atomic_set(&gyro_state->common_attributes.data_ready,
> > > > > > 0);
> > > > > > +
> > > > > >         ret = hid_sensor_setup_trigger(indio_dev, name,
> > > > > >                                         &gyro_state-
> > > > > > > common_attributes);
> > > > > >         if (ret < 0) {
> > > > > >                 dev_err(&pdev->dev, "trigger setup failed\n");
> > > > > > -               goto error_unreg_buffer_funcs;
> > > > > > +               goto error_free_dev_mem;
> > > > > >         }
> > > > > >
> > > > > >         ret = iio_device_register(indio_dev);
> > > > > > @@ -361,9 +354,7 @@ static int hid_gyro_3d_probe(struct
> > > > > > platform_device *pdev)
> > > > > >  error_iio_unreg:
> > > > > >         iio_device_unregister(indio_dev);
> > > > > >  error_remove_trigger:
> > > > > > -       hid_sensor_remove_trigger(&gyro_state-
> > > > > > >common_attributes);
> > > > > > -error_unreg_buffer_funcs:
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &gyro_state-
> > > > > > > common_attributes);
> > > > > >  error_free_dev_mem:
> > > > > >         kfree(indio_dev->channels);
> > > > > >         return ret;
> > > > > > @@ -378,8 +369,7 @@ static int hid_gyro_3d_remove(struct
> > > > > > platform_device *pdev)
> > > > > >
> > > > > >         sensor_hub_remove_callback(hsdev,
> > > > > > HID_USAGE_SENSOR_GYRO_3D);
> > > > > >         iio_device_unregister(indio_dev);
> > > > > > -       hid_sensor_remove_trigger(&gyro_state-
> > > > > > >common_attributes);
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &gyro_state-
> > > > > > > common_attributes);
> > > > > >         kfree(indio_dev->channels);
> > > > > >
> > > > > >         return 0;
> > > > > > diff --git a/drivers/iio/humidity/hid-sensor-humidity.c
> > > > > > b/drivers/iio/humidity/hid-sensor-humidity.c
> > > > > > index c99b54b0568d..d2318c4aab0f 100644
> > > > > > --- a/drivers/iio/humidity/hid-sensor-humidity.c
> > > > > > +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> > > > > > @@ -7,8 +7,6 @@
> > > > > >  #include <linux/hid-sensor-hub.h>
> > > > > >  #include <linux/iio/buffer.h>
> > > > > >  #include <linux/iio/iio.h>
> > > > > > -#include <linux/iio/triggered_buffer.h>
> > > > > > -#include <linux/iio/trigger_consumer.h>
> > > > > >  #include <linux/module.h>
> > > > > >  #include <linux/platform_device.h>
> > > > > >
> > > > > > @@ -233,12 +231,8 @@ static int hid_humidity_probe(struct
> > > > > > platform_device *pdev)
> > > > > >         indio_dev->name = name;
> > > > > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > >
> > > > > > -       ret = devm_iio_triggered_buffer_setup(&pdev->dev,
> > > > > > indio_dev,
> > > > > > -                                       &iio_pollfunc_store_tim
> > > > > > e, NULL,
> > > > > > NULL);
> > > > > > -       if (ret)
> > > > > > -               return ret;
> > > > > > -
> > > > > >         atomic_set(&humid_st->common_attributes.data_ready, 0);
> > > > > > +
> > > > > >         ret = hid_sensor_setup_trigger(indio_dev, name,
> > > > > >                                 &humid_st->common_attributes);
> > > > > >         if (ret)
> > > > > > @@ -261,7 +255,7 @@ static int hid_humidity_probe(struct
> > > > > > platform_device *pdev)
> > > > > >  error_remove_callback:
> > > > > >         sensor_hub_remove_callback(hsdev,
> > > > > > HID_USAGE_SENSOR_HUMIDITY);
> > > > > >  error_remove_trigger:
> > > > > > -       hid_sensor_remove_trigger(&humid_st-
> > > > > > >common_attributes);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &humid_st-
> > > > > > > common_attributes);
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > @@ -274,7 +268,7 @@ static int hid_humidity_remove(struct
> > > > > > platform_device *pdev)
> > > > > >
> > > > > >         iio_device_unregister(indio_dev);
> > > > > >         sensor_hub_remove_callback(hsdev,
> > > > > > HID_USAGE_SENSOR_HUMIDITY);
> > > > > > -       hid_sensor_remove_trigger(&humid_st-
> > > > > > >common_attributes);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &humid_st-
> > > > > > > common_attributes);
> > > > > >
> > > > > >         return 0;
> > > > > >  }
> > > > > > diff --git a/drivers/iio/light/hid-sensor-als.c
> > > > > > b/drivers/iio/light/hid-sensor-als.c
> > > > > > index b6cd299517d1..81fa2a422797 100644
> > > > > > --- a/drivers/iio/light/hid-sensor-als.c
> > > > > > +++ b/drivers/iio/light/hid-sensor-als.c
> > > > > > @@ -14,8 +14,6 @@
> > > > > >  #include <linux/iio/iio.h>
> > > > > >  #include <linux/iio/sysfs.h>
> > > > > >  #include <linux/iio/buffer.h>
> > > > > > -#include <linux/iio/trigger_consumer.h>
> > > > > > -#include <linux/iio/triggered_buffer.h>
> > > > > >  #include "../common/hid-sensors/hid-sensor-trigger.h"
> > > > > >
> > > > > >  enum {
> > > > > > @@ -308,18 +306,13 @@ static int hid_als_probe(struct
> > > > > > platform_device
> > > > > > *pdev)
> > > > > >         indio_dev->name = name;
> > > > > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > >
> > > > > > -       ret = iio_triggered_buffer_setup(indio_dev,
> > > > > > &iio_pollfunc_store_time,
> > > > > > -               NULL, NULL);
> > > > > > -       if (ret) {
> > > > > > -               dev_err(&pdev->dev, "failed to initialize
> > > > > > trigger
> > > > > > buffer\n");
> > > > > > -               goto error_free_dev_mem;
> > > > > > -       }
> > > > > >         atomic_set(&als_state->common_attributes.data_ready,
> > > > > > 0);
> > > > > > +
> > > > > >         ret = hid_sensor_setup_trigger(indio_dev, name,
> > > > > >                                 &als_state->common_attributes);
> > > > > >         if (ret < 0) {
> > > > > >                 dev_err(&pdev->dev, "trigger setup failed\n");
> > > > > > -               goto error_unreg_buffer_funcs;
> > > > > > +               goto error_free_dev_mem;
> > > > > >         }
> > > > > >
> > > > > >         ret = iio_device_register(indio_dev);
> > > > > > @@ -343,9 +336,7 @@ static int hid_als_probe(struct
> > > > > > platform_device
> > > > > > *pdev)
> > > > > >  error_iio_unreg:
> > > > > >         iio_device_unregister(indio_dev);
> > > > > >  error_remove_trigger:
> > > > > > -       hid_sensor_remove_trigger(&als_state-
> > > > > > >common_attributes);
> > > > > > -error_unreg_buffer_funcs:
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &als_state-
> > > > > > > common_attributes);
> > > > > >  error_free_dev_mem:
> > > > > >         kfree(indio_dev->channels);
> > > > > >         return ret;
> > > > > > @@ -360,8 +351,7 @@ static int hid_als_remove(struct
> > > > > > platform_device
> > > > > > *pdev)
> > > > > >
> > > > > >         sensor_hub_remove_callback(hsdev,
> > > > > > HID_USAGE_SENSOR_ALS);
> > > > > >         iio_device_unregister(indio_dev);
> > > > > > -       hid_sensor_remove_trigger(&als_state-
> > > > > > >common_attributes);
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &als_state-
> > > > > > > common_attributes);
> > > > > >         kfree(indio_dev->channels);
> > > > > >
> > > > > >         return 0;
> > > > > > diff --git a/drivers/iio/light/hid-sensor-prox.c
> > > > > > b/drivers/iio/light/hid-sensor-prox.c
> > > > > > index 7e1030af9ba3..e9c04df07344 100644
> > > > > > --- a/drivers/iio/light/hid-sensor-prox.c
> > > > > > +++ b/drivers/iio/light/hid-sensor-prox.c
> > > > > > @@ -14,8 +14,6 @@
> > > > > >  #include <linux/iio/iio.h>
> > > > > >  #include <linux/iio/sysfs.h>
> > > > > >  #include <linux/iio/buffer.h>
> > > > > > -#include <linux/iio/trigger_consumer.h>
> > > > > > -#include <linux/iio/triggered_buffer.h>
> > > > > >  #include "../common/hid-sensors/hid-sensor-trigger.h"
> > > > > >
> > > > > >  #define CHANNEL_SCAN_INDEX_PRESENCE 0
> > > > > > @@ -286,18 +284,13 @@ static int hid_prox_probe(struct
> > > > > > platform_device *pdev)
> > > > > >         indio_dev->name = name;
> > > > > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > >
> > > > > > -       ret = iio_triggered_buffer_setup(indio_dev,
> > > > > > &iio_pollfunc_store_time,
> > > > > > -               NULL, NULL);
> > > > > > -       if (ret) {
> > > > > > -               dev_err(&pdev->dev, "failed to initialize
> > > > > > trigger
> > > > > > buffer\n");
> > > > > > -               goto error_free_dev_mem;
> > > > > > -       }
> > > > > >         atomic_set(&prox_state->common_attributes.data_ready,
> > > > > > 0);
> > > > > > +
> > > > > >         ret = hid_sensor_setup_trigger(indio_dev, name,
> > > > > >                                 &prox_state-
> > > > > > >common_attributes);
> > > > > >         if (ret) {
> > > > > >                 dev_err(&pdev->dev, "trigger setup failed\n");
> > > > > > -               goto error_unreg_buffer_funcs;
> > > > > > +               goto error_free_dev_mem;
> > > > > >         }
> > > > > >
> > > > > >         ret = iio_device_register(indio_dev);
> > > > > > @@ -321,9 +314,7 @@ static int hid_prox_probe(struct
> > > > > > platform_device
> > > > > > *pdev)
> > > > > >  error_iio_unreg:
> > > > > >         iio_device_unregister(indio_dev);
> > > > > >  error_remove_trigger:
> > > > > > -       hid_sensor_remove_trigger(&prox_state-
> > > > > > >common_attributes);
> > > > > > -error_unreg_buffer_funcs:
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &prox_state-
> > > > > > > common_attributes);
> > > > > >  error_free_dev_mem:
> > > > > >         kfree(indio_dev->channels);
> > > > > >         return ret;
> > > > > > @@ -338,8 +329,7 @@ static int hid_prox_remove(struct
> > > > > > platform_device
> > > > > > *pdev)
> > > > > >
> > > > > >         sensor_hub_remove_callback(hsdev,
> > > > > > HID_USAGE_SENSOR_PROX);
> > > > > >         iio_device_unregister(indio_dev);
> > > > > > -       hid_sensor_remove_trigger(&prox_state-
> > > > > > >common_attributes);
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &prox_state-
> > > > > > > common_attributes);
> > > > > >         kfree(indio_dev->channels);
> > > > > >
> > > > > >         return 0;
> > > > > > diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > > > > b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > > > > index 25e60b233e08..0c09daf87794 100644
> > > > > > --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > > > > +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > > > > @@ -14,8 +14,6 @@
> > > > > >  #include <linux/iio/iio.h>
> > > > > >  #include <linux/iio/sysfs.h>
> > > > > >  #include <linux/iio/buffer.h>
> > > > > > -#include <linux/iio/trigger_consumer.h>
> > > > > > -#include <linux/iio/triggered_buffer.h>
> > > > > >  #include "../common/hid-sensors/hid-sensor-trigger.h"
> > > > > >
> > > > > >  enum magn_3d_channel {
> > > > > > @@ -519,18 +517,13 @@ static int hid_magn_3d_probe(struct
> > > > > > platform_device *pdev)
> > > > > >         indio_dev->name = name;
> > > > > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > >
> > > > > > -       ret = iio_triggered_buffer_setup(indio_dev,
> > > > > > &iio_pollfunc_store_time,
> > > > > > -               NULL, NULL);
> > > > > > -       if (ret) {
> > > > > > -               dev_err(&pdev->dev, "failed to initialize
> > > > > > trigger
> > > > > > buffer\n");
> > > > > > -               return ret;
> > > > > > -       }
> > > > > >         atomic_set(&magn_state-
> > > > > > >magn_flux_attributes.data_ready, 0);
> > > > > > +
> > > > > >         ret = hid_sensor_setup_trigger(indio_dev, name,
> > > > > >                                         &magn_state-
> > > > > > > magn_flux_attributes);
> > > > > >         if (ret < 0) {
> > > > > >                 dev_err(&pdev->dev, "trigger setup failed\n");
> > > > > > -               goto error_unreg_buffer_funcs;
> > > > > > +               return ret;
> > > > > >         }
> > > > > >
> > > > > >         ret = iio_device_register(indio_dev);
> > > > > > @@ -554,9 +547,7 @@ static int hid_magn_3d_probe(struct
> > > > > > platform_device *pdev)
> > > > > >  error_iio_unreg:
> > > > > >         iio_device_unregister(indio_dev);
> > > > > >  error_remove_trigger:
> > > > > > -       hid_sensor_remove_trigger(&magn_state-
> > > > > > >magn_flux_attributes);
> > > > > > -error_unreg_buffer_funcs:
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &magn_state-
> > > > > > > magn_flux_attributes);
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > @@ -569,8 +560,7 @@ static int hid_magn_3d_remove(struct
> > > > > > platform_device *pdev)
> > > > > >
> > > > > >         sensor_hub_remove_callback(hsdev,
> > > > > > HID_USAGE_SENSOR_COMPASS_3D);
> > > > > >         iio_device_unregister(indio_dev);
> > > > > > -       hid_sensor_remove_trigger(&magn_state-
> > > > > > >magn_flux_attributes);
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &magn_state-
> > > > > > > magn_flux_attributes);
> > > > > >
> > > > > >         return 0;
> > > > > >  }
> > > > > > diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c
> > > > > > b/drivers/iio/orientation/hid-sensor-incl-3d.c
> > > > > > index 00af68764cda..6aac8bea233a 100644
> > > > > > --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> > > > > > +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> > > > > > @@ -15,8 +15,6 @@
> > > > > >  #include <linux/iio/iio.h>
> > > > > >  #include <linux/iio/sysfs.h>
> > > > > >  #include <linux/iio/buffer.h>
> > > > > > -#include <linux/iio/trigger_consumer.h>
> > > > > > -#include <linux/iio/triggered_buffer.h>
> > > > > >  #include "../common/hid-sensors/hid-sensor-trigger.h"
> > > > > >
> > > > > >  enum incl_3d_channel {
> > > > > > @@ -346,18 +344,13 @@ static int hid_incl_3d_probe(struct
> > > > > > platform_device *pdev)
> > > > > >         indio_dev->name = name;
> > > > > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > >
> > > > > > -       ret = iio_triggered_buffer_setup(indio_dev,
> > > > > > &iio_pollfunc_store_time,
> > > > > > -               NULL, NULL);
> > > > > > -       if (ret) {
> > > > > > -               dev_err(&pdev->dev, "failed to initialize
> > > > > > trigger
> > > > > > buffer\n");
> > > > > > -               goto error_free_dev_mem;
> > > > > > -       }
> > > > > >         atomic_set(&incl_state->common_attributes.data_ready,
> > > > > > 0);
> > > > > > +
> > > > > >         ret = hid_sensor_setup_trigger(indio_dev, name,
> > > > > >                                         &incl_state-
> > > > > > > common_attributes);
> > > > > >         if (ret) {
> > > > > >                 dev_err(&pdev->dev, "trigger setup failed\n");
> > > > > > -               goto error_unreg_buffer_funcs;
> > > > > > +               goto error_free_dev_mem;
> > > > > >         }
> > > > > >
> > > > > >         ret = iio_device_register(indio_dev);
> > > > > > @@ -382,9 +375,7 @@ static int hid_incl_3d_probe(struct
> > > > > > platform_device *pdev)
> > > > > >  error_iio_unreg:
> > > > > >         iio_device_unregister(indio_dev);
> > > > > >  error_remove_trigger:
> > > > > > -       hid_sensor_remove_trigger(&incl_state-
> > > > > > >common_attributes);
> > > > > > -error_unreg_buffer_funcs:
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &incl_state-
> > > > > > > common_attributes);
> > > > > >  error_free_dev_mem:
> > > > > >         kfree(indio_dev->channels);
> > > > > >         return ret;
> > > > > > @@ -399,8 +390,7 @@ static int hid_incl_3d_remove(struct
> > > > > > platform_device *pdev)
> > > > > >
> > > > > >         sensor_hub_remove_callback(hsdev,
> > > > > > HID_USAGE_SENSOR_INCLINOMETER_3D);
> > > > > >         iio_device_unregister(indio_dev);
> > > > > > -       hid_sensor_remove_trigger(&incl_state-
> > > > > > >common_attributes);
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &incl_state-
> > > > > > > common_attributes);
> > > > > >         kfree(indio_dev->channels);
> > > > > >
> > > > > >         return 0;
> > > > > > diff --git a/drivers/iio/orientation/hid-sensor-rotation.c
> > > > > > b/drivers/iio/orientation/hid-sensor-rotation.c
> > > > > > index 64ae7d04a200..b99f41240e3e 100644
> > > > > > --- a/drivers/iio/orientation/hid-sensor-rotation.c
> > > > > > +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> > > > > > @@ -14,8 +14,6 @@
> > > > > >  #include <linux/iio/iio.h>
> > > > > >  #include <linux/iio/sysfs.h>
> > > > > >  #include <linux/iio/buffer.h>
> > > > > > -#include <linux/iio/trigger_consumer.h>
> > > > > > -#include <linux/iio/triggered_buffer.h>
> > > > > >  #include "../common/hid-sensors/hid-sensor-trigger.h"
> > > > > >
> > > > > >  struct dev_rot_state {
> > > > > > @@ -288,18 +286,13 @@ static int hid_dev_rot_probe(struct
> > > > > > platform_device *pdev)
> > > > > >         indio_dev->name = name;
> > > > > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > >
> > > > > > -       ret = iio_triggered_buffer_setup(indio_dev,
> > > > > > &iio_pollfunc_store_time,
> > > > > > -               NULL, NULL);
> > > > > > -       if (ret) {
> > > > > > -               dev_err(&pdev->dev, "failed to initialize
> > > > > > trigger
> > > > > > buffer\n");
> > > > > > -               return ret;
> > > > > > -       }
> > > > > >         atomic_set(&rot_state->common_attributes.data_ready,
> > > > > > 0);
> > > > > > +
> > > > > >         ret = hid_sensor_setup_trigger(indio_dev, name,
> > > > > >                                         &rot_state-
> > > > > > >common_attributes);
> > > > > >         if (ret) {
> > > > > >                 dev_err(&pdev->dev, "trigger setup failed\n");
> > > > > > -               goto error_unreg_buffer_funcs;
> > > > > > +               return ret;
> > > > > >         }
> > > > > >
> > > > > >         ret = iio_device_register(indio_dev);
> > > > > > @@ -323,9 +316,7 @@ static int hid_dev_rot_probe(struct
> > > > > > platform_device *pdev)
> > > > > >  error_iio_unreg:
> > > > > >         iio_device_unregister(indio_dev);
> > > > > >  error_remove_trigger:
> > > > > > -       hid_sensor_remove_trigger(&rot_state-
> > > > > > >common_attributes);
> > > > > > -error_unreg_buffer_funcs:
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &rot_state-
> > > > > > > common_attributes);
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > @@ -338,8 +329,7 @@ static int hid_dev_rot_remove(struct
> > > > > > platform_device *pdev)
> > > > > >
> > > > > >         sensor_hub_remove_callback(hsdev, hsdev->usage);
> > > > > >         iio_device_unregister(indio_dev);
> > > > > > -       hid_sensor_remove_trigger(&rot_state-
> > > > > > >common_attributes);
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &rot_state-
> > > > > > > common_attributes);
> > > > > >
> > > > > >         return 0;
> > > > > >  }
> > > > > > diff --git a/drivers/iio/pressure/hid-sensor-press.c
> > > > > > b/drivers/iio/pressure/hid-sensor-press.c
> > > > > > index 953235052155..5e6663f757ae 100644
> > > > > > --- a/drivers/iio/pressure/hid-sensor-press.c
> > > > > > +++ b/drivers/iio/pressure/hid-sensor-press.c
> > > > > > @@ -14,8 +14,6 @@
> > > > > >  #include <linux/iio/iio.h>
> > > > > >  #include <linux/iio/sysfs.h>
> > > > > >  #include <linux/iio/buffer.h>
> > > > > > -#include <linux/iio/trigger_consumer.h>
> > > > > > -#include <linux/iio/triggered_buffer.h>
> > > > > >  #include "../common/hid-sensors/hid-sensor-trigger.h"
> > > > > >
> > > > > >  #define CHANNEL_SCAN_INDEX_PRESSURE 0
> > > > > > @@ -290,18 +288,13 @@ static int hid_press_probe(struct
> > > > > > platform_device *pdev)
> > > > > >         indio_dev->name = name;
> > > > > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > >
> > > > > > -       ret = iio_triggered_buffer_setup(indio_dev,
> > > > > > &iio_pollfunc_store_time,
> > > > > > -               NULL, NULL);
> > > > > > -       if (ret) {
> > > > > > -               dev_err(&pdev->dev, "failed to initialize
> > > > > > trigger
> > > > > > buffer\n");
> > > > > > -               goto error_free_dev_mem;
> > > > > > -       }
> > > > > >         atomic_set(&press_state->common_attributes.data_ready,
> > > > > > 0);
> > > > > > +
> > > > > >         ret = hid_sensor_setup_trigger(indio_dev, name,
> > > > > >                                 &press_state-
> > > > > > >common_attributes);
> > > > > >         if (ret) {
> > > > > >                 dev_err(&pdev->dev, "trigger setup failed\n");
> > > > > > -               goto error_unreg_buffer_funcs;
> > > > > > +               goto error_free_dev_mem;
> > > > > >         }
> > > > > >
> > > > > >         ret = iio_device_register(indio_dev);
> > > > > > @@ -325,9 +318,7 @@ static int hid_press_probe(struct
> > > > > > platform_device
> > > > > > *pdev)
> > > > > >  error_iio_unreg:
> > > > > >         iio_device_unregister(indio_dev);
> > > > > >  error_remove_trigger:
> > > > > > -       hid_sensor_remove_trigger(&press_state-
> > > > > > >common_attributes);
> > > > > > -error_unreg_buffer_funcs:
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &press_state-
> > > > > > > common_attributes);
> > > > > >  error_free_dev_mem:
> > > > > >         kfree(indio_dev->channels);
> > > > > >         return ret;
> > > > > > @@ -342,8 +333,7 @@ static int hid_press_remove(struct
> > > > > > platform_device *pdev)
> > > > > >
> > > > > >         sensor_hub_remove_callback(hsdev,
> > > > > > HID_USAGE_SENSOR_PRESSURE);
> > > > > >         iio_device_unregister(indio_dev);
> > > > > > -       hid_sensor_remove_trigger(&press_state-
> > > > > > >common_attributes);
> > > > > > -       iio_triggered_buffer_cleanup(indio_dev);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &press_state-
> > > > > > > common_attributes);
> > > > > >         kfree(indio_dev->channels);
> > > > > >
> > > > > >         return 0;
> > > > > > diff --git a/drivers/iio/temperature/hid-sensor-temperature.c
> > > > > > b/drivers/iio/temperature/hid-sensor-temperature.c
> > > > > > index eda55b9c1e9b..8d1f434f109d 100644
> > > > > > --- a/drivers/iio/temperature/hid-sensor-temperature.c
> > > > > > +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> > > > > > @@ -7,8 +7,6 @@
> > > > > >  #include <linux/hid-sensor-hub.h>
> > > > > >  #include <linux/iio/buffer.h>
> > > > > >  #include <linux/iio/iio.h>
> > > > > > -#include <linux/iio/triggered_buffer.h>
> > > > > > -#include <linux/iio/trigger_consumer.h>
> > > > > >  #include <linux/module.h>
> > > > > >  #include <linux/platform_device.h>
> > > > > >
> > > > > > @@ -230,12 +228,8 @@ static int hid_temperature_probe(struct
> > > > > > platform_device *pdev)
> > > > > >         indio_dev->name = name;
> > > > > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > >
> > > > > > -       ret = devm_iio_triggered_buffer_setup(&pdev->dev,
> > > > > > indio_dev,
> > > > > > -                                       &iio_pollfunc_store_tim
> > > > > > e, NULL,
> > > > > > NULL);
> > > > > > -       if (ret)
> > > > > > -               return ret;
> > > > > > -
> > > > > >         atomic_set(&temp_st->common_attributes.data_ready, 0);
> > > > > > +
> > > > > >         ret = hid_sensor_setup_trigger(indio_dev, name,
> > > > > >                                 &temp_st->common_attributes);
> > > > > >         if (ret)
> > > > > > @@ -258,7 +252,7 @@ static int hid_temperature_probe(struct
> > > > > > platform_device *pdev)
> > > > > >  error_remove_callback:
> > > > > >         sensor_hub_remove_callback(hsdev,
> > > > > > HID_USAGE_SENSOR_TEMPERATURE);
> > > > > >  error_remove_trigger:
> > > > > > -       hid_sensor_remove_trigger(&temp_st->common_attributes);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &temp_st-
> > > > > > > common_attributes);
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > @@ -270,7 +264,7 @@ static int hid_temperature_remove(struct
> > > > > > platform_device *pdev)
> > > > > >         struct temperature_state *temp_st =
> > > > > > iio_priv(indio_dev);
> > > > > >
> > > > > >         sensor_hub_remove_callback(hsdev,
> > > > > > HID_USAGE_SENSOR_TEMPERATURE);
> > > > > > -       hid_sensor_remove_trigger(&temp_st->common_attributes);
> > > > > > +       hid_sensor_remove_trigger(indio_dev, &temp_st-
> > > > > > > common_attributes);
> > > > > >
> > > > > >         return 0;
> > > > > >  }
> >
